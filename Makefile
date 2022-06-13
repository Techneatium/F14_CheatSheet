SHELL := /bin/bash

CURRENT_PATH = $(shell pwd)
REPO = # ghcr.io
IMAGE = techneatium/techs-checks-latex
TAG = latest
FULL_IMAGE = ${REPO}${IMAGE}:${TAG}
TARGET = F14_CheatSheet.tex

.PHONY: build_container
prepare_image: clean_fonts
	docker build -t ${FULL_IMAGE} .

.PHONY: build_pdf
build_pdf:
	mkdir -p ./build
	source scripts/set_build_info.sh
	docker run --rm -it \
		-v ${CURRENT_PATH}:/source:rw,Z \
		--entrypoint /bin/bash ${FULL_IMAGE} -c "\
		cd /source &&\
		scripts/set_build_info.sh &&\
		cp -v /fonts/* /source/. &&\
		lualatex --output-format=pdf --output-folder=/source/build ${TARGET}"

.PHONY: build
build: clean build_pdf

.PHONY: clean_fonts
clean_fonts:
	find ${CURRENT_PATH} -iregex '.*[.]\(ttf\|otf\)' -delete

.PHONY: clean_build
clean_build:
	find ${CURRENT_PATH} -iregex '.*[.]\(aux\|cb[0-9]?\|log\|maf\|mtc[0-9]?\|out\|toc\)' -delete

.PHONY: clean
clean: clean_fonts clean_build
