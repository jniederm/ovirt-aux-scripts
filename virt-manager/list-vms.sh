#!/usr/bin/env bash

if [[ $EUID != 0 ]] ; then
    echo "root permitions required";
    exit 1
fi

process_line() {
    LINE=$1
    local ORIGINAL_IFS=IFS
    local IFS=' '
    local MAC=$(echo $LINE | cut -f 2 -d ' ' | xargs sudo virsh dumpxml | grep '<mac ' | grep -oP '(\w{2}:){5}\w{2}')
    local IP=$(echo $ARP | grep $MAC | cut -f 1 -d ' ')
    IP=${IP:--}
    IFS=ORIGINAL_IFS
    echo -e $LINE \\t $IP
}

RAW_LIST=$(virsh list --all | grep -P -- '(-|(\d+))\s+\S+\s+\S+')
ARP=$(arp)

ORIGINAL_IFS=$IFS
IFS='
'
for LINE in $RAW_LIST
do
    process_line $LINE
done
IFS=$ORIGINAL_IFS

