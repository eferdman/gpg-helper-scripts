#!/bin/bash
#
# just contains get_device_list for now

set -a

DEVICES=device_list

# store parsed lsblk output in device_list file
get_device_list() {
	lsblk -lo type,name,vendor,size | 
	grep disk | 
	sed "s/^disk  //" > $DEVICES
}
