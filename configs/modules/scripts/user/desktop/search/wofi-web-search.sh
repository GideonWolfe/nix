#!/usr/bin/env -S nix shell nixpkgs#bash --command bash
#
# Script name: dmsearch
# Description: Search various search engines (inspired by surfraw).
# Dependencies: dmenu and brave
# GitLab: https://www.gitlab.com/dwt1/dmscripts
# License: https://www.gitlab.com/dwt1/dmscripts/LICENSE
# Contributors: Derek Taylor
#               Ali Furkan Yıldız
#               HostGrady
#               Simon Ingelsson

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

# function get_config() {
  # local loaded=0
  # declare -a config_dirs=(
  # "${HOME}/.config/dmscripts/config"
  # "/etc/dmscripts/config"
  # )
  # for conf in "${config_dirs[@]}"; do
    # if [[ -f ${conf} ]]; then
      # echo "${conf}"
      # loaded=1
      # break
    # fi
  # done
  # [[ ${loaded} -eq 0 ]] && echo "No config found" ; exit 1
# }

# script will not hit this if there is no config-file to load
# shellcheck disable=SC1090
# source "$(get_config)"


declare -A search_options
# Syntax:
# search_options[name]="https://www.example.com/search?q="

# Search Engines
search_options[bing]="https://www.bing.com/search?q="
search_options[duckduckgo]="https://duckduckgo.com/?q="
search_options[google]="https://www.google.com/search?q="
# Information/News
search_options[bbcnews]="https://www.bbc.co.uk/search?q="
search_options[cnn]="https://www.cnn.com/search?q="
search_options[googlenews]="https://news.google.com/search?q="
search_options[wikipedia]="https://en.wikipedia.org/wiki/"
search_options[wiktionary]="https://en.wiktionary.org/wiki/"
# Social Media
search_options[reddit]="https://www.reddit.com/search/?q="
search_options[youtube]="https://www.youtube.com/results?search_query="
# Online Shopping
search_options[amazon]="https://www.amazon.com/s?k="
search_options[craigslist]="https://newyork.craigslist.org/search/sss?query="
search_options[ebay]="https://www.ebay.com/sch/i.html?&_nkw="
# Linux
search_options[archaur]="https://aur.archlinux.org/packages/?O=0&K="
search_options[archpkg]="https://archlinux.org/packages/?sort=&q="
search_options[archwiki]="https://wiki.archlinux.org/index.php?search="
search_options[nixpkgs]="https://search.nixos.org/packages?channel=23.11&type=packages&query="
search_options[nixopts]="https://search.nixos.org/options?channel=23.11&query="
# Development
search_options[github]="https://github.com/search?q="
search_options[gitlab]="https://gitlab.com/search?search="
search_options[googleOpenSource]="https://opensource.google/projects/search?q="
search_options[sourceforge]="https://sourceforge.net/directory/?q="
search_options[stackoverflow]="https://stackoverflow.com/search?q="
# Etc
search_options[ultimateguitar]="https://www.ultimate-guitar.com/search.php?search_type=title&value="

BROWSER='firefox'

# As this is loaded from other file it is technically not defined
# shellcheck disable=SC2154 # Choosing  a search engine by name from array above.
engine=$(printf '%s\n' "${!search_options[@]}" | sort | wofi --dmenu -i -L 20 --prompt 'Choose search engine:') "$@" || exit

# Getting the url of the search engine we chose.
url="${search_options["${engine}"]}"

# Searching the chosen engine.
query=$(echo "$engine" | wofi --dmenu --prompt 'Enter search query:')

# Display search results in web browser
${BROWSER} "${url}${query}"
