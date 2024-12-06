#!/bin/sh

file=$1
w=$2
h=$3
x=$4
y=$5

filetype="$( file -Lb --mime-type "$file")"

if [[ "$filetype" =~ ^image ]]; then
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty && \
        exit 1
fi

if [[ "$filetype" =~ ^video ]]; then
    # vidthumb is from here:
    # https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$(vidthumb "$file")" < /dev/null > /dev/tty && \
        exit 1
fi

case "$1" in
    *.md) glow -s dark "$1" ;;
    *.tgz | *.tar.gz) tar tzf "$1" ;;
    *.tar.bz2 | *.tbz2) tar tjf "$1" ;;
    *.tar.txz | *.txz) xz --list "$1" ;;
    *.tar) tar tf "$1" ;;
    *.zip | *.jar | *.war | *.ear | *.oxt) unzip -l "$1" ;;
    *.rar) unrar l "$1" ;;
    *.7z) 7z l "$1" ;;
    *.[1-8]) man "$1" | col -b ;;
    *.o) nm "$1" | less ;;
    *.torrent) transmission-show "$1" ;;
    *odt,*.ods,*.odp,*.sxw) odt2txt "$1" ;;
    *.doc) antiword "$1" ;;
    *.docx) docx2txt.pl "$1" - ;;
    .xls) xls2csv "$1" ;;
    *.xlsx) xlsx2csv "$1" ;;
    *.csv) cat "$1" | sed s/,/\\n/g ;;
    *.pdf) pdftotext -l 10 -nopgbrk -q "$1" - ;;
    *.bmp | *.jpg | *.jpeg | *.png | *.xpm) mediainfo "$1" ;;
    *.wav | *.mp3 | *.flac | *.m4a | *.wma | *.ape | *.ac3 | *.og[agx] | *.spx | *.opus | *.as[fx] | *.flac) mediainfo "$1" ;;
    *.avi | *.mp4 | *.wmv | *.dat | *.3gp | *.ogv | *.mkv | *.mpg | *.mpeg | *.vob | *.fl[icv] | *.m2v | *.mov | *.webm | *.mts | *.m4v | *.r[am] | *.qt | *.divx) mediainfo "$1" ;;
    *.json) jq --color-output . "$1" || bat --color=always --style=numbers,changes --line-range=:"$3" "$1" ;;
    *) bat --color=always --style=numbers,changes --line-range=:"$3" "$1" || highlight -O truecolor -s molokai --force -l --line-range=1-"$3" "$1" || cat "$1" ;;
esac
