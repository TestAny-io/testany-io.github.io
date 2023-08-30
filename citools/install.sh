#!/bin/bash

cat > citools << 'EOF'
#!/bin/bash

_get-version() {
  local version=$(git describe --tags --abbrev=0 --match "*.*.*")
  echo -n "$version"
}

_is-tagged() {
  git describe --tags --exact-match --match "*.*.*" > /dev/null 2>&1
}

_tag-version() {
  if _is-tagged; then
    return
  fi
  local branch=$(git rev-parse --abbrev-ref HEAD)
  local version=$(git describe --tags --abbrev=0 --match "*.*.*")
  local comments=$(git log "$version"...HEAD --format=%s)
  if echo "$comments" | grep '(MAJOR)' > /dev/null ; then
    version=$(semver bump major "$version")
  elif echo "$comments" | grep '(MINOR)' > /dev/null; then
    version=$(semver bump minor "$version")
  elif echo "$comments" | grep '(PATCH)' > /dev/null; then
    version=$(semver bump patch "$version")
  elif [ "$branch" == "dev" ]; then
    version=$(semver bump patch "$version")
  elif [ "$branch" == "qa" ]; then
    version=$(semver bump minor "$version")
  else
    echo "unknown branch"
    exit -1
  fi
  git tag "$version"
}

_git-pushable-remote() {
  git remote set-url origin "https://ta-bitbucket-bot:${GIT_PUSH_APPKEY}@bitbucket.org/${BITBUCKET_REPO_OWNER}/${BITBUCKET_REPO_SLUG}"
}

_git-merge() {
  local base="$1"
  local head="$2"
  local head_commitid="$3"
  local version=$(_get-version)
  local issuekey=$(_get-issuekey)
  git fetch origin "$base"
  git checkout -b "$base" FETCH_HEAD
  git merge "$head_commitid" --no-ff -m "(RELEASE)[$issuekey]merge from $head to $base, $head version: $version $4"
  git push origin "$base"
}

_aws-assume-role() {
  export AWS_REGION="cn-northwest-1"
  export AWS_ROLE_ARN="${AWS_BITBUCKET_ARN}"
  export AWS_WEB_IDENTITY_TOKEN_FILE=$(pwd)/web-identity-token
  echo $BITBUCKET_STEP_OIDC_TOKEN > $(pwd)/web-identity-token
  aws sts assume-role-with-web-identity --role-arn "$AWS_ROLE_ARN" \
      --role-session-name build-session --web-identity-token "$BITBUCKET_STEP_OIDC_TOKEN" \
      --duration-seconds 1000 > /dev/null
  export -p | grep AWS
}

_get-issuekey() {
  local comment=$(git log -1 --format=%B)
  local issue_key=$(echo "$comment" | head -n 1 | grep -oP '\w+-\d+')
  echo -n "$issue_key"
}

_send-event() {
  local step="$1"
  local status="successful"
  if [[ ${BITBUCKET_EXIT_CODE} -ne 0 ]]; then
    status="failed"
  fi
  local body='{
  "buildnum":"'${BITBUCKET_BUILD_NUMBER}'",
  "url":"https://bitbucket.org/'${BITBUCKET_REPO_FULL_NAME}'/pipelines/results/'${BITBUCKET_BUILD_NUMBER}'",
  "repo":"'${BITBUCKET_REPO_SLUG}'",
  "branch": "'${BITBUCKET_BRANCH}'",
  "exitcode": "'${BITBUCKET_EXIT_CODE}'",
  "step": "'${step}'",
  "status":"'${status}'",
  "version": "'$(_get-version)'",
  "issuekey": "'$(_get-issuekey)'"}'

  echo "$body"
  if [[ "$step" == "unittest" ]]; then
    local url='https://automation.atlassian.com/pro/hooks/9732c7cbf398a8635c0d7fc49d0c0320fd46c271'
  elif [[ "$step" == "build" || "$step" == "buildimg" ]]; then
    local url='https://automation.atlassian.com/pro/hooks/ff1cd6b9c6fd65c5c6b137fa3d54c3eee478b761'
  elif [[ "$step" == "integration" ]]; then
    local url='https://automation.atlassian.com/pro/hooks/51a36f6505505fa7edf14d820d27d66634298a90'
  fi
  curl -v -X POST -H 'Content-Type: application/json' -d "$body" "$url"
}

_help() {
    declare -F | while read line;
    do
	if [ ${line:11:1} == "_" ]; then
	    echo ${line:12}
	fi
    done
}

fn="$1"
shift
if declare -F "_$fn" > /dev/null
then
    "_$fn" "$@"
else
    _help
fi
EOF

chmod +x citools
