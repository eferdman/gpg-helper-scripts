#!/bin/bash
#
# Runs the TUI scripts for selected menu item

set -a
set -e

while true
do
	main_menu "task"

	case $task in
		"Generate Primary and Subkeys") 
			./whiptail/get_keys.sh ;;
		"Generate Only Primary Key") ;;
		"Select Disks")
			./get_disks.sh ;;
		"RAID a set of SD Cards")
			./whiptail/raid_disks.sh ;;
		"Add UID") 
			;;
		"Create an additional subkey") ;;
		"Initialize a SmartCard") ;;
		"Set Pins on SmartCard") ;;
	esac
done