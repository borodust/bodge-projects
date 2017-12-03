WORK_DIR="$(dir $(abspath $(lastword $(MAKEFILE_LIST))))"
BUILD_DIR=$(WORK_DIR)/build/
DIST_ROOT=$(BUILD_DIR)/dist/

SBCL=sbcl

TAR=$(shell which gtar | which tar)

build: package

prepare:
	mkdir -p $(DIST_ROOT)

dist: prepare
	$(SBCL) --load $(WORK_DIR)/dist.lisp \
		--eval '(quit)' \
		$(TAR) $(WORK_DIR) $(DIST_ROOT)

package: dist
	cd $(BUILD_DIR) && zip -r dist.zip dist/

deploy:
	scp $(BUILD_DIR)/dist.zip root.develserv:~/
	ssh root.develserv /root/update-dist.sh

clean:
	rm -rf $(BUILD_DIR)
