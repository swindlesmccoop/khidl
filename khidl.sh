#!/bin/sh

[ "$1" = "" ] && read -r -p "Please enter query: " QUERY || QUERY="$1"
curl "https://downloads.khinsider.com/search?search=$QUERY" -so .result.html
SEL="$(grep -Po '(?<=                <a href="/game-soundtracks/album/).*(?=</a></td>)' .result.html | sed 's/^.*">//' | fzf --layout=reverse --height 40%)"
LINK="https://downloads.khinsider.com$(grep "$SEL" .result.html | grep -Po '<a href="/game-soundtracks/album/.*">' | sed 's/<a href="//' | sed 's/">//')"

mkdir "$SEL" && cd "$SEL"
curl "$LINK" | grep -Po #this is where the hard part is

rm ../.result.html .result.html
