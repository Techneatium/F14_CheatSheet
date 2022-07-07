#!/usr/bin/env bash
set -o errexit \
    -o pipefail \
    -o nounset

tlmgr update --self
tlmgr install \
    datetime \
    fmtcount \
    enumitem \
    titlesec \
    siunitx \
    tikzpagenodes \
    ifoddpage \
    lipsum \
    ragged2e \
    footmisc \
    tocloft \
    minitoc \
    chappg \
    tcolorbox \
    environ \
    luatex85 \
    changebar
