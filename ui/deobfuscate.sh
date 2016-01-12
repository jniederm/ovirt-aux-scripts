#!/usr/bin/env bash

if [ $# != 1 ] ; then
    echo 'Usage: deobfuscate.sh <symbolmap_file>'
    echo '       input text expected in clipboard'
    exit 1
fi

SYMBOLMAP_FILE=$1


xclip -o -selection clipboard | grep -oP '\.\w+\(' | grep -oP '\w+' | xargs -L 1 -I % grep -P ^%, $SYMBOLMAP_FILE
