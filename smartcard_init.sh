#!/bin/bash

# smartcard-init.sh initializes the smartcard for the user
# Prompts for Surname, Given Name, Language Preferences, Login, 
# Admin PIN, User PIN, and Reset Code

set -a

# Ask if the user will be using a smartcard
whiptail --yesno "Would you like to send your keys to a smartcard?" 8 78 --title "Smart Card"

exitstatus=$?
if [ $exitstatus = 0 ]; then
	
	# SMARTCARD INITIALIZATION
	if (whiptail --yesno "Would you like to initialize a smartcard with your name, language, and login?" 8 78 --title "Smart Card Initialization") then
		
		SMARTCARD_SURNAME=$(whiptail --inputbox "Please enter the Cardholder's Surname" 8 78 --title "Cardholder's Surname" 3>&1 1>&2 2>&3)
		
		SMARTCARD_NAME=$(whiptail --inputbox "Please enter the Cardholder's First Name" 8 78 --title "Cardholder's First Name" 3>&1 1>&2 2>&3)
		
		SMARTCARD_LANG=$(whiptail --inputbox "Please enter the Preferred Language. E.g. en, fr, de" 8 78 en --title "Cardholder's Preferred Language" 3>&1 1>&2 2>&3)
		
		SMARTCARD_LOGIN=$(whiptail --inputbox "Please enter the Cardholder's Login Name" 8 78 --title "Cardholder's Login" 3>&1 1>&2 2>&3)
	fi

	# SET ADMIN PIN 
	if (whiptail --yesno "Would you like to set/change the Admin PIN of your smartcard?" 8 78 --title "Change Admin PIN") then
		while true
		do
			OLD_ADMIN=$(whiptail --passwordbox "Please enter the old Admin PIN" 8 78 12345678 --title "Old Admin PIN" 3>&1 1>&2 2>&3)

			CONF_OLD_ADMIN=$(whiptail --passwordbox "Please re-enter your old Admin PIN" 8 78 12345678 --title "Verify Old Admin PIN" 3>&1 1>&2 2>&3)

			[ $OLD_ADMIN = $CONF_OLD_ADMIN ] && break
		done

		while true
		do
			ADMIN=$(whiptail --passwordbox "Please enter the new Admin PIN" 8 78 --title "New Admin PIN" 3>&1 1>&2 2>&3)
		
			CONF_ADMIN=$(whiptail --passwordbox "Please re-enter the new Admin PIN" 8 78 --title "Verify New Admin PIN" 3>&1 1>&2 2>&3)

			[ $ADMIN = $CONF_ADMIN ] && break
		done
	fi

	# SET USER PIN
	if (whiptail --yesno "Would you like to set/change the User PIN on your smartcard?" 8 78 --title "Change User PIN") then
		while true
		do
			OLD_PIN=$(whiptail --passwordbox "Please enter the old User PIN" 8 78 123456 --title "Old User PIN" 3>&1 1>&2 2>&3)

			CONF_OLD_PIN=$(whiptail --passwordbox "Please re-enter your old User PIN" 8 78 123456 --title "Verify Old User PIN" 3>&1 1>&2 2>&3)

			[ $OLD_PIN = $CONF_OLD_PIN ] && break
		done

		while true
		do
			PIN=$(whiptail --passwordbox "Please enter the new PIN" 8 78 --title "New PIN" 3>&1 1>&2 2>&3)
		
			CONF_PIN=$(whiptail --passwordbox "Please re-enter the new PIN" 8 78 --title "Verify New PIN" 3>&1 1>&2 2>&3)

			[ $PIN = $CONF_PIN ] && break
		done
	fi

	# SET RESET CODE
	if (whiptail --yesno "Would you like to set the reset code for your smartcard?" 8 78 --title "Set Reset Code") then
		while true
		do
			RESET=$(whiptail --passwordbox "Please enter the new Reset Code" 8 78 --title "New Reset Code" 3>&1 1>&2 2>&3)

			CONF_RESET=$(whiptail --passwordbox "Please re-enter the new Reset Code" 8 78 --title "Verify New Reset Code" 3>&1 1>&2 2>&3)

			[ $RESET = $CONF_RESET ] && break
		done
	fi

fi