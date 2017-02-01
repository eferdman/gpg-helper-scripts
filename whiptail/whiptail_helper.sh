#!/bin/bash
#
# whiptail helper functions

set -e
set -a

DIMENS="15 78"

#########################################
# Stores user input as variable
# Arguments:
# 	$1 the name for the variable
# 	$2 whiptail text
# 	$3 whiptail title
# 	$4 whiptail default value (optional) 
#########################################
whiptail_input() {
	__resultvar=$1
	if [[ ! -z $4 ]]; then
		result=$(whiptail --inputbox "$(gettext $2)" $DIMENS "$(gettext $4)" --title "$(gettext $3)" 3>&1 1>&2 2>&3)
	else
		result=$(whiptail --inputbox "$(gettext $2)" $DIMENS --title "$(gettext $3)" 3>&1 1>&2 2>&3)
	fi
	eval $__resultvar="'$result'"
}

whiptail_yesno() {	
	whiptail --yesno "$(gettext $1)" $DIMENS --title "$(gettext $2)"
	return $?
}

whiptail_password() {
	__resultvar=$1	
	result=$(whiptail --passwordbox "$(gettext $2)" $DIMENS --title "$(gettext $3)" 3>&1 1>&2 2>&3)
	eval $__resultvar="'$result'"
}

whiptail_menu() {
	__resultvar=$1	
	result=$(whiptail --title "PGP Clean Room Menu" --menu \
		"		
				Welcome to the PGP Clean Room! Please choose an option." 15 80 5 \
"Generate Primary and Subkeys" "(Default)" \
"Generate Only Primary Key" "" \
"Create an additional subkey" "(Custom)" \
"Initialize a SmartCard" "" \
"Set Pins on SmartCard" "" 3>&1 1>&2 2>&3)
	eval $__resultvar="'$result'"
}