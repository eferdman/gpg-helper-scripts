#!/bin/bash
#
# whiptail helper functions

set -e
set -a

. lib/get_devices.sh

DIMENS="15 78"

#########################################
# Stores user input from whiptail --input as variable
# Arguments:
# 	$1 the name for the variable
# 	$2 whiptail text
# 	$3 whiptail title
# 	$4 whiptail default value (optional) 
#########################################
whiptail_input() {
	__resultvar=$1
	default=$1_DEFAULT
	if [[ -z $2 ]]; then
		default=$1_DEFAULT
	else
		default=$2
	fi
	result=$(whiptail --inputbox "$(gettext $1_TEXT)" \
	$DIMENS ${!default} --title "$(gettext $1_TITLE)" 3>&1 1>&2 2>&3)
	eval $__resultvar="'$result'"
}

get_expiry() {
	__resultvar=$1
	default=$1_DEFAULT
	result=$(whiptail --inputbox "$(gettext "EXPIRY_TEXT")" $DIMENS \
	${!default} --title "$(gettext $1_TITLE)" 3>&1 1>&2 2>&3)
	eval $__resultvar="'$result'"
}

#########################################
# Asks user to answer yes or no
# Arguments:
# 	$1 whiptail text
# 	$2 whiptail title
# 	$3 name of disk (optional)
#########################################
whiptail_yesno() {
	whiptail --yesno "$(gettext $1) $3" $DIMENS --title "$(gettext $2)"
	return $?
}

#########################################
# Stores user input from whiptail password dialog as variable
# Arguments:
# 	$1 the name for the variable
# 	$2 whiptail text
# 	$3 whiptail title
#########################################
whiptail_password() {
	__resultvar=$1	
	result=$(whiptail --passwordbox "$(gettext $1_TEXT)" $DIMENS --title "$(gettext $1_TITLE)" 3>&1 1>&2 2>&3)
	eval $__resultvar="'$result'"
}

#########################################
# Stores user's selected disk from whiptail --radio 
# Arguments:
# 	$1 the name for the variable
#########################################
whiptail_select_disk() {
	__resultvar=$1

	# get_device_list

	# build whiptail command string
	ws="whiptail --title \"$(gettext $1_TITLE)\" --radiolist \"$(gettext $1_TEXT)\" 20 80 5"

	# append lines in device_list file to the whiptail string
	while read line; do
		ws="$ws \"/dev/$(cut -f1 -d ' ' <<< $line)\" \"$(sed "s/^sd. //" <<< $line)\" OFF";
	done <device_list

	# append redirection
	ws="$ws 3>&1 1>&2 2>&3"

	disks="'$(eval $ws)'"

	# store the name of device as variable, e.g. "/dev/sdb"
	eval $__resultvar=$disks
}

#########################################
# Stores user's 2+ selected disks from whiptail --checklist 
# Arguments:
# 	$1 the name for the variable
#########################################
whiptail_raid_disks() {
	__resultvar=$1

	#get_device_list

	# build whiptail command string
	ws="whiptail --title \"$(gettext $1_TITLE)\" --checklist \"$(gettext $1_TEXT)\" 20 80 5"

	# append lines in device_list file to the whiptail string
	while read line; do
		ws="$ws \"/dev/$(cut -f1 -d ' ' <<< $line)\" \"$(sed "s/^sd. //" <<< $line)\" OFF";
	done <device_list

	# append redirection
	ws="$ws 3>&1 1>&2 2>&3"

	raid_disks="'$(eval $ws)'"

	# store the names of the two devices as variable, e.g. '"/dev/sdb" "/dev/sdc"'
	eval $__resultvar=$raid_disks
}

#########################################
# Stores user's selection from whiptail --radio dialog
# Arguments:
# 	$1 the name for the variable
#	$@ the radio choices, first one is ON
#########################################
whiptail_radio() {
	__resultvar=$1
	ws="whiptail --title \"$(gettext $1_TITLE)\" --radiolist \"$(gettext $1_TEXT)\" 15 80 10"
	shift
	for option in "$@"
	do
		if [ "$option" = $1 ]; then
			ws="$ws \"$option\" \"\" ON"
		else
			ws="$ws \"$option\" \"\" OFF"
		fi
	done
	
	# append redirection
	ws="$ws 3>&1 1>&2 2>&3"

	# store the user's selection as variable
	selection="'$(eval $ws)'"
	eval $__resultvar=$selection
}

whiptail_checkbox() {
	__resultvar=$1
	ws="whiptail --title \"$(gettext $1_TITLE)\" --checklist \"$(gettext $1_TEXT)\" 15 80 3"
	shift
	for option in "$@"
	do
		if [ $option == $1 ]; then
			ws="$ws \"$option\" \"\" ON"
		else
			ws="$ws \"$option\" \"\" OFF"
		fi
	done
	
	# append redirection
	ws="$ws 3>&1 1>&2 2>&3"

	# store the user's selection as variable
	selection="'$(eval $ws)'"
	eval $__resultvar=$selection
}


#########################################
# Main Menu
# Arguments:
# 	$1 the name for the variable: "task"
#########################################
main_menu() {
	__resultvar=$1	
	result=$(whiptail --title "PGP Clean Room Main Menu" --menu \
		"		
				Please choose a task from the list below:" 20 80 12 \
"RAID a set of SD Cards" "" \
"Generate Primary and Subkeys (Default)" "" \
"Generate Primary and Subkeys (Custom)" "" \
"Generate Primary and Subkeys (Expert)" "" \
"Generate Primary Key (Custom)" "" \
"Add Subkey (Custom)" "" \
"Add UID" "" \
"Initialize a SmartCard" "" \
"Set Pins on SmartCard" "" \
"Rotate Subkey" "" \
"Sign (Certify) Keys" "" \
"Backup Keyring to Disk" "" 3>&1 1>&2 2>&3)
		
	# store user's selection as variable
	eval $__resultvar="'$result'"

	case $task in
		"RAID a set of SD Cards")
			. whiptail/raid_disks.sh ;;
		"Generate Primary and Subkeys (Default)")
			. whiptail/quick_get_keys.sh 
			#./gpg/quick_gen_key.sh 
			;;
		"Generate Primary and Subkeys (Custom)") 
			. whiptail/get_keys.sh ;;
		"Generate Primary and Subkeys (Expert)")
			;;
		"Generate Only Primary Key (Custom)")
			. whiptail/get_primary_key.sh ;;
		"Add Subkey (Custom)")
			. whiptail/get_subkey.sh ;;
		"Select Disks")
			. get_disks.sh ;;
		"Add UID") ;;
		"Initialize a SmartCard")
			. whiptail/smartcard_init.sh ;;
		"Set Pins on SmartCard") ;;
		"Rotate Subkey") ;;
		"Sign (Certify) Keys") ;;
		"Backup Keyring to Disk") ;;
	esac
}

# dummy gauge
whiptail_gauge() {
	{
	    for ((i = 0 ; i <= 100 ; i+=5)); do
	        sleep 0.1
	        echo $i
	    done
	} | whiptail --gauge "Please wait while partitioning $1" 6 60 0	
}
