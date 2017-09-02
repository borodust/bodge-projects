WORK_DIR="$(dir $(abspath $(lastword $(MAKEFILE_LIST))))"
BUILD_DIR=$(WORK_DIR)/build/
DIST_ROOT=$(BUILD_DIR)/dist/

SBCL=sbcl


build: package

prepare:
	mkdir -p $(DIST_ROOT)

dist: prepare
	$(SBCL) --load $(WORK_DIR)/dist.lisp \
		--eval '(quit)' \
		$(shell which gtar) \
		$(WORK_DIR) $(DIST_ROOT)

package: dist
	cd $(BUILD_DIR) && zip -r dist.zip dist/

clean:
	rm -rf $(BUILD_DIR)
