#!/bin/bash
#
# smartcard-init.sh initializes the smartcard for the user
# Prompts for Surname, Given Name, Language Preferences, Login, 
# Admin PIN, User PIN, and Reset Code

set -a
set -e

# keep this for testing
. init.sh
. whiptail_helper.sh

# Ask if the user will be using a smartcard
if whiptail_yesno "SMARTCARD_YESNO_TEXT" "SMARTCARD_YESNO_TITLE"; then
	
	# SMARTCARD INITIALIZATION
	if whiptail_yesno "SMARTCARD_INIT_YESNO_TEXT" "SMARTCARD_INIT_YESNO_TITLE"; then
		
		whiptail_input "SMARTCARD_SURNAME" "SMARTCARD_SURNAME_TEXT" "SMARTCARD_SURNAME_TITLE"
		
		whiptail_input "SMARTCARD_NAME" "SMARTCARD_NAME_TEXT" "SMARTCARD_NAME_TITLE"
		
		whiptail_input "SMARTCARD_LANG" "SMARTCARD_LANG_TEXT" "SMARTCARD_LANG_TITLE" 
		
		whiptail_input "SMARTCARD_LOGIN" "SMARTCARD_LOGIN_TEXT" "SMARTCARD_LOGIN_TITLE"
	fi

	# SET ADMIN PIN 
	if whiptail_yesno "ADMIN_PIN_YESNO_TEXT" "ADMIN_PIN_YESNO_TITLE"; then
		while true
		do
			whiptail_password "OLD_ADMIN" "OLD_ADMIN_PIN_TEXT" "OLD_ADMIN_PIN_TITLE"

			whiptail_password "OLD_ADMIN_CONF" "OLD_ADMIN_PIN_CONF_TEXT" "OLD_ADMIN_PIN_CONF_TITLE"

			[ $OLD_ADMIN = $OLD_ADMIN_CONF ] && break
		done

		while true
		do
			whiptail_password "ADMIN" "NEW_ADMIN_PIN_TEXT" "NEW_ADMIN_PIN_TITLE"
		
			whiptail_password "ADMIN_CONF" "NEW_ADMIN_PIN_CONF_TEXT" "OLD_ADMIN_PIN_CONF_TITLE"

			[ $ADMIN = $ADMIN_CONF ] && break
		done
	fi

	# SET USER PIN
	if whiptail_yesno "USER_PIN_YESNO_TEXT" "USER_PIN_YESNO_TITLE"; then
		while true
		do
			whiptail_password "OLD_PIN" "OLD_USER_PIN_TEXT" "OLD_USER_PIN_TITLE"

			whiptail_password "OLD_PIN_CONF" "OLD_USER_PIN_CONF_TEXT" "OLD_USER_PIN_CONF_TITLE"

			[ $OLD_PIN = $OLD_PIN_CONF ] && break
		done

		while true
		do
			whiptail_password "PIN" "NEW_USER_PIN_TEXT" "NEW_USER_PIN_TITLE"
		
			whiptail_password "PIN_CONF" "NEW_USER_PIN_CONF_TEXT" "NEW_USER_PIN_CONF_TITLE"

			[ $PIN = $PIN_CONF ] && break
		done
	fi

	# SET RESET CODE
	if whiptail_yesno "RESET_CODE_YESNO_TEXT" "RESET_CODE_YESNO_TITLE"; then
		while true
		do
			whiptail_password "RESET" "RESET_CODE_TEXT" "RESET_CODE_TITLE"

			whiptail_password "CONF_RESET" "RESET_CODE_CONF_TEXT" "RESET_CODE_CONF_TITLE"

			[ $RESET = $RESET_CONF ] && break
		done
	fi

fi