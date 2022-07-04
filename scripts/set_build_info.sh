#!/usr/bin/env bash
set -o errexit \
    -o pipefail \
    -o nounset

if [ ! -z "$(git status --untracked-files=no --porcelain)" ]; then
    BUILD_TYPE=dirty
elif git describe --exact-match --tags HEAD > /dev/null; then
    BUILD_TYPE=release
else 
    BUILD_TYPE=non-release
fi

if [[ "${BUILD_TYPE}" == "release" ]]; then
    BUILD_VERSION="$(git tag --points-at HEAD)"
elif [[ "${BUILD_TYPE}" == "non-release" ]]; then
    BUILD_VERSION="$(git rev-parse --short HEAD)"
else
    BUILD_VERSION="$(date '+%s')"
fi

_short_build_type='\\newcommand{\\versionprefix}'
_build_version='\\newcommand{\\buildversion}'

if [[ "${BUILD_TYPE}" == "release" ]]; then
    sed -i "s/${_short_build_type}.*/${_short_build_type}{REV:}/" TechCheck.cls
elif [[ "${BUILD_TYPE}" == "non-release" ]]; then
    sed -i "s/${_short_build_type}.*/${_short_build_type}{NRL:}/" TechCheck.cls
elif [[ "${BUILD_TYPE}" == "dirty" ]]; then
    sed -i "s/${_short_build_type}.*/${_short_build_type}{DRT:}/" TechCheck.cls
else
    sed -i "s/${_short_build_type}.*/${_short_build_type}{UNK:}/" TechCheck.cls
fi

sed -i "s/${_build_version}.*/${_build_version}{${BUILD_VERSION}}/" TechCheck.cls
