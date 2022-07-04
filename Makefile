SHELL := /bin/bash
.DEFAULT_GOAL := build

DOCKER_BIN=$(shell which podman || which docker)

CURRENT_PATH = $(shell pwd)
IMAGE = techneatium/techs-checks-latex
TAG = latest
FULL_IMAGE = ${REPO}${IMAGE}:${TAG}
TARGET = F14_CheatSheet.tex

.PHONY: build_container
prepare_image: clean_fonts
	${DOCKER_BIN} build -t ${FULL_IMAGE} .

.PHONY: build_pdf
build_pdf:
	mkdir -p ./build
	source scripts/set_build_info.sh
	- ${DOCKER_BIN} run --rm -it \
		-v ${CURRENT_PATH}:/source:rw,Z \
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
