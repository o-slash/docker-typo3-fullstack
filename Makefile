VENDOR=mulgo
IMAGE=typo3-toolchain
BUILD_DATE=`date -u +"%Y%m%d"`
VCS_REF=`git rev-parse --short HEAD`

VERSIONS = 6.2 7.6 8.7

.PHONY: all default build $(VERSIONS)

build: $(VERSIONS)

default: build

all: default

$(VERSIONS):
	cp -f typo3.ini $@
	cp -f typo3.conf $@
	cp -f run-typo3.sh $@ 
	@docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		-t $(VENDOR)/$(IMAGE):$@-$(BUILD_DATE) ./$@
	@docker tag $(VENDOR)/$(IMAGE):$@-$(BUILD_DATE) $(VENDOR)/$(IMAGE):$@-latest
	@docker tag $(VENDOR)/$(IMAGE):$@-$(BUILD_DATE) $(VENDOR)/$(IMAGE):$@