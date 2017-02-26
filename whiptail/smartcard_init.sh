#!/bin/bash
#
# smartcard-init.sh initializes the smartcard for the user
# Prompts for Surname, Given Name, Language Preferences, Login, 
# Admin PIN, User PIN, and Reset Code

set -a
set -e

# Ask if the user will be using a smartcard
if whiptail_yesno "SMARTCARD_YESNO_TEXT" "SMARTCARD_YESNO_TITLE"; then
	
	# SMARTCARD INITIALIZATION
	if whiptail_yesno "SMARTCARD_INIT_YESNO_TEXT" "SMARTCARD_INIT_YESNO_TITLE"; then
		
		whiptail_input "SMARTCARD_SURNAME" 
		
		whiptail_input "SMARTCARD_NAME" 
		
		whiptail_input "SMARTCARD_LANG" 
		
		whiptail_input "SMARTCARD_LOGIN"
	fi

	# SET ADMIN PIN 
	if whiptail_yesno "ADMIN_PIN_YESNO_TEXT" "ADMIN_PIN_YESNO_TITLE"; then

		confirm_password "OLD_ADMIN_PIN" "OLD_ADMIN_PIN_CONF"

		confirm_password "NEW_ADMIN_PIN" "NEW_ADMIN_PIN_CONF"
	fi

	# SET USER PIN
	if whiptail_yesno "USER_PIN_YESNO_TEXT" "USER_PIN_YESNO_TITLE"; then
		
		confirm_password "OLD_USER_PIN" "OLD_USER_PIN_CONF"

		confirm_password "NEW_USER_PIN" "NEW_USER_PIN_CONF"
	fi

	# SET RESET CODE
	if whiptail_yesno "RESET_CODE_YESNO_TEXT" "RESET_CODE_YESNO_TITLE"; then
		
		confirm_password "RESET_CODE" "RESET_CODE_CONF"
	fi

fi