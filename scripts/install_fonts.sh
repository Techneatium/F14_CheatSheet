#!/usr/bin/env bash
set -o errexit \
    -o pipefail \
    -o nounset

mkdir /fonts

# Spartan
for f in /usr/share/fonts/opentype/league-spartan/LeagueSpartan-*.otf; do
    _font_file_name="$(basename "${f}")"
    _new_font_name="$(sed 's/League//' <<< "${_font_file_name}")"
    cp -v "${f}" "/fonts/${_new_font_name}"
done

cp -v /fonts/Spartan-Regular.otf /fonts/Spartan.otf

# Jost
curl -fL --output /tmp/jost.zip https://fonts.google.com/download?family=Jost

cd /tmp
unzip -o jost.zip
cp -v /tmp/static/Jost-*.ttf /fonts/.
