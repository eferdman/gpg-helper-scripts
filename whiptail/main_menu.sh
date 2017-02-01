#!/bin/bash
#
# main_menu.sh 

set -a
set -e

# keep this for testing
. whiptail/whiptail_helper.sh
. init.sh

whiptail_menu "task"

case $task in
	"Generate Primary and Subkeys") 
		./whiptail/user_info.sh ;;
	"Generate Only Primary Key") ;;
	"Create an additional subkey") ;;
	"Initialize a SmartCard") ;;
	"Set Pins on SmartCard") ;;
esac