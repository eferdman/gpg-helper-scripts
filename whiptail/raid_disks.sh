#!/bin/bash
#
# This script can act as a whiptail frontend 
# for the create-raid script:
# https://anonscm.debian.org/git/collab-maint/make-pgp-clean-room.git/tree/resources/config/includes.chroot/usr/local/sbin/create-raid
# Asks for md|btrfs RAID mechanism 
# and at least 2 devices
# To run raid-devices:
# create-raid $RAID_MECHANISM $RAID_DEVICES

# Ask user to specify RAID mechanism md|btrfs
whiptail_radio "RAID_MECHANISM" "md" "btrfs"

# Ask the user for at least 2 devices
while [ $(wc -w <<< "$RAID_DEVICES") -lt 2 ]
do
	whiptail_raid_disks "RAID_DEVICES"
done

echo $RAID_DEVICES

if whiptail_yesno \
	"PARTITION_CONFIRM_TEXT" \
	"PARTITION_CONFIRM_TITLE" "$RAID_DEVICES"; then
		# TODO: pipe the new script to whiptail --gauge
		# dummy gauge
		whiptail_gauge "$RAID_DEVICES"
fi