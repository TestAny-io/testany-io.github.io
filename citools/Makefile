### Makefile --- 

## Author: shell@mpb21
## Version: $Id: Makefile,v 0.0 2023/07/19 07:48:42 shell Exp $
## Keywords: 
## X-URL: 
DEPS=citools gitver semver

all: clean install.sh install.tgz

clean:
	rm -f install.sh install.tgz

install.sh: $(DEPS)
	./packsh $^ > $@

install.tgz: $(DEPS)
	tar --transform 's|^|.git/|' -czf $@ $^

### Makefile ends here
