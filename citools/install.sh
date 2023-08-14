#!/bin/bash

curl -fsSL -o /usr/bin/citools "https://testany-io.bitbucket.io/citools/citools"
chmod +x /usr/bin/citools

curl -fsSL -o /usr/bin/semver "https://raw.githubusercontent.com/fsaintjacques/semver-tool/master/src/semver"
chmod +x /usr/bin/semver
