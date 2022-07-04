SHELL := /bin/bash
.DEFAULT_GOAL := build

DOCKER_BIN=$(shell which podman || which docker)
PODMAN_VM_NAME = podman-vm-pdfbuilder
UNAME := $(shell uname)

CURRENT_PATH = $(shell pwd)
IMAGE = techneatium/techs-checks-latex
TAG = latest
FULL_IMAGE = ${REPO}${IMAGE}:${TAG}
TARGET = F14_CheatSheet.tex

.PHONY: macos_podman_preparation
macos_podman_preparation:
# Mount cwd into podman virtual machine on macOS
# Should only be run once
ifeq ($(UNAME), Darwin)
	${DOCKER_BIN} machine init --volume ${CURRENT_PATH}:${CURRENT_PATH} ${PODMAN_VM_NAME}
endif

.PHONY: macos_setup
macos_setup:
# Start the podman virtual machine on macOS
ifeq ($(UNAME), Darwin)
	${DOCKER_BIN} machine start ${PODMAN_VM_NAME}
endif

.PHONY: macos_teardown
macos_teardown:
# Stop the podman virtual machine on macOS
ifeq ($(UNAME), Darwin)
	${DOCKER_BIN} machine stop ${PODMAN_VM_NAME}
endif

.PHONY: build_container
prepare_image: clean_fonts
	${DOCKER_BIN} build -t ${FULL_IMAGE} .

.PHONY: build_pdf
build_pdf:
	mkdir -p ./build
	source scripts/set_build_info.sh
	- ${DOCKER_BIN} run \
		--rm \
		--interactive \
		--tty \
		--security-opt label=disable \
		--volume ${CURRENT_PATH}:/source:rw \
		--entrypoint /bin/bash ${FULL_IMAGE} -c "\
		cd /source &&\
		scripts/set_build_info.sh &&\
		mkdir -p fonts &&\
		cp -v /fonts/* /source/fonts/. &&\
		cp -v /source/fonts/LeagueSpartan-Regular.ttf /source/fonts/LeagueSpartan.ttf &&\
		lualatex --output-format=pdf ${TARGET} &&\
		lualatex --output-format=pdf ${TARGET} &&\
		lualatex --output-format=pdf ${TARGET}"

.PHONY: build
build: clean_before build_pdf clean_after

.PHONY: clean_before
clean_before:
	find ${CURRENT_PATH} -iregex '.*[.]\(ttf\|otf\)' -delete
	find ${CURRENT_PATH} -iregex '.*[.]\(aux\|cb[0-9]?\|log\|maf\|mtc[0-9]?\|out\|toc\)' -delete

.PHONY: clean_after
clean_after:
	find ${CURRENT_PATH} -iregex '.*[.]\(ttf\|otf\)' -delete
	find ${CURRENT_PATH} -iregex '.*[.]\(aux\|cb[0-9]?\|log\|maf\|mtc[0-9]?\|out\|toc\)' -delete

clean: clean_before
