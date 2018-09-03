WORK_DIR="$(dir $(abspath $(lastword $(MAKEFILE_LIST))))"
BUILD_DIR=$(WORK_DIR)/build/
DIST_ROOT=$(BUILD_DIR)/dist/

LISP ?= sbcl

ifeq ($(LISP),sbcl)
RUN_LISP=$(LISP) --load $(WORK_DIR)/dist.lisp --eval '(quit)'
endif
ifeq ($(LISP),ccl)
RUN_LISP=$(LISP) --load $(WORK_DIR)/dist.lisp --eval '(quit)' --
endif
ifndef RUN_LISP
$(error Unrecognized lisp: $(LISP))
endif

TAR=$(shell which gtar | which tar)

DIST_NAME ?= "org.borodust.bodge"
DIST_POSTFIX ?= ""
DIST_FULL_NAME = $(DIST_NAME)$(DIST_POSTFIX)

build: package

prepare:
	mkdir -p $(DIST_ROOT)

dist: prepare
	$(RUN_LISP) $(DIST_FULL_NAME) $(TAR) $(WORK_DIR) $(DIST_ROOT)

package: dist
	cd $(BUILD_DIR) && zip -r dist.zip dist/

deploy:
	scp $(BUILD_DIR)/dist.zip root.develserv:~/
	ssh root.develserv /root/update-dist.sh $(DIST_FULL_NAME)

clean:
	rm -rf $(BUILD_DIR)
