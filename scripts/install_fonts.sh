#!/usr/bin/env bash
set -o errexit \
    -o pipefail \
    -o nounset

mkdir /fonts

# https://stackoverflow.com/questions/6250698/how-to-decode-url-encoded-string-in-shell
function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

# Fetch and extract a font from Google Fonts
function install_google_font() {
    echo "Downloading $(urldecode "${1}")"

    curl --fail \
         --location \
         --output "/tmp/${1}.zip" "https://fonts.google.com/download?family=${1}"

    unzip -o -d /tmp "/tmp/${1}.zip"
}

# Array of all the fonts to download off off Google Fonts
# To add fonts, simply extract the family name from the download link
_fonts=(\
    "Jost"\
    "League%20Spartan"\
    "Inter"\
    "IBM%20Plex%20Sans"\
)

# shellcheck disable=SC2048
for font in ${_fonts[*]}; do install_google_font "${font}"; done

# Download the Metropolis font from GitHub
echo "Downloading Metropolis"

# Here, the release version is specified to avoid surprises
curl --fail \
     --location \
     --output "/tmp/metropolis-r11.zip" https://github.com/dw5/Metropolis/archive/refs/tags/r11.zip

unzip -o -d /tmp "/tmp/metropolis-r11.zip"

# Copy all the font files to the staging folder
find /tmp -iregex ".*[.]\(ttf\|otf\)" -exec cp -t /fonts -v {} +
