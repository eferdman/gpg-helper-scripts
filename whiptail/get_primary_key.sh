#!/bin/bash
#
# user-info.sh gathers the user's uids and key preferences

set -a
set -e

# UIDS
whiptail_input "PRIMARY_UID" "PRIMARY_UID_TEXT" "PRIMARY_UID_TITLE" 
whiptail_input "ADD_UIDS" "ADD_UIDS_TEXT" "ADD_UIDS_TITLE" 

# MASTER KEY
whiptail_input "MASTER_KEY_ALGO" "MASTER_KEY_ALGO_TEXT" "MASTER_KEY_ALGO_TITLE" "MASTER_KEY_ALGO_DEFAULT"
whiptail_input "MASTER_EXPIRY" "EXPIRY_TEXT" "MASTER_EXPIRY_TITLE" "MASTER_EXPIRY_DEFAULT" 

# PASSWORD: Validate that password is 12 chars and confirm password
while true
do
	while true
	do
		whiptail_password "PASSWORD" "PASSWORD_TEXT" "PASSWORD_TITLE"
		[ ${#PASSWORD} -ge 12 ] && break
	done
	whiptail_password "CONF_PASSWORD" "CONF_PASSWORD_TEXT" "CONF_PASSWORD_TITLE"
	[ $PASSWORD = $CONF_PASSWORD ] && break
done