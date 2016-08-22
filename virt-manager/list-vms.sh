#!/usr/bin/env bash

# todo add args --serial-console/-c and --ssh/-s, list table, read number, connect/print error

# see http://stackoverflow.com/questions/19057915/libvirt-fetch-ipv4-address-from-guest
# see sudo virsh net-dhcp-leases <network-name>
# see sudo virsh domiflist <vm-name>

process_virsh_list_line() {
    LINE=$1
    local ORIGINAL_IFS=IFS
    local IFS=' '
    local MACS=$(echo $LINE | cut -f 2 -d ' ' | xargs sudo virsh dumpxml | grep '<mac ' | grep -oP '(\w{2}:){5}\w{2}')
    echo -en "$LINE \\t"
    while read MAC ; do
        local IP=$(mac_to_ip "$MAC")
        echo -n " $IP"
    done <<< "$MACS"
    echo
}

# in: mac string
# out: either IP if found or '-'
mac_to_ip() {
    local MAC=$1
    local IP=$(echo "$ARP" | grep $MAC | cut -f 1 -d ' ')
    IP="${IP:--}"
    echo $IP
}

RAW_LIST=$(virsh list --all | grep -P -- '(-|(\d+))\s+\S+\s+\S+')
if [[ x"$RAW_LIST" == x && $EUID != 0 ]] ; then
    echo '`virsh list --all` output no vms and script is not run as root. Try `sudo` or check out https://major.io/2015/04/11/run-virsh-and-access-libvirt-as-a-regular-user/';
    exit 1
fi

ARP=$(arp)

ORIGINAL_IFS=$IFS
IFS='
'
for LINE in $RAW_LIST
do
    process_virsh_list_line $LINE
done
IFS=$ORIGINAL_IFS

