#!/bin/bash

# user-info.sh gathers the user's uids and key preferences

set -a
set -e

. gen_key_strings.sh

# UIDS
PRIMARY_UID=$(whiptail --inputbox "$PRIMARY_UID_TEXT_EN" 8 78 --title "$PRIMARY_UID_TITLE_EN" 3>&1 1>&2 2>&3)
ADD_UIDS=$(whiptail --inputbox "$ADD_UIDS_TEXT_EN" 15 78 --title "$ADD_UIDS_TITLE_EN" 3>&1 1>&2 2>&3)

# MASTER KEY
MASTER_KEY_ALGO=$(whiptail --inputbox "$MASTER_KEY_ALGO_TEXT_EN" 15 78 $MASTER_KEY_ALGO_DEFAULT --title "$MASTER_KEY_ALGO_TITLE_EN" 3>&1 1>&2 2>&3)
MASTER_EXPIRY=$(whiptail --inputbox "$EXPIRY_TEXT_EN" 15 78 $MASTER_EXPIRY_DEFAULT --title "$MASTER_EXPIRY_TITLE_EN" 3>&1 1>&2 2>&3)

# SECONDARY KEY
SUBKEY_ALGO=$(whiptail --inputbox "$SUBKEY_ALGO_TEXT_EN" 15 78 $SUBKEY_ALGO_DEFAULT --title "$SUBKEY_ALGO_TITLE_EN" 3>&1 1>&2 2>&3)
SUBKEY_EXPIRY=$(whiptail --inputbox "$EXPIRY_TEXT_EN" 15 78 $SUBKEY_EXPIRY_DEFAULT --title "$SUBKEY_EXPIRY_TITLE_EN" 3>&1 1>&2 2>&3)

# PASSWORD: Validate that password is 12 chars and confirm password
while true
do
	while true
	do
		PASSWORD=$(whiptail --passwordbox "$PASSWORD_TEXT_EN" 8 78 --title "$PASSWORD_TITLE_EN" 3>&1 1>&2 2>&3)
		[ ${#PASSWORD} -ge 12 ] && break
	done
	CONF_PASSWORD=$(whiptail --passwordbox "$CONF_PASSWORD_TEXT_EN" 8 78 --title "$CONF_PASSWORD_TITLE_EN" 3>&1 1>&2 2>&3)
	[ $PASSWORD = $CONF_PASSWORD ] && break
done

# ENCRYPTION SUBKEY
if (whiptail --yesno "$ENCR_SUBKEY_YESNO_TEXT_EN" 8 78 --title "$ENCR_SUBKEY_YESNO_TITLE_EN") then
	ENCR_SUBKEY=$(whiptail --inputbox "$ENCR_SUBKEY_TEXT_EN" 15 78 $SUBKEY_ALGO_DEFAULT --title "$ENCR_SUBKEY_TITLE_EN" 3>&1 1>&2 2>&3)
	ENCR_SUBKEY_EXPIRY=$(whiptail --inputbox "$EXPIRY_TEXT_EN" 15 78 $SUBKEY_EXPIRY_DEFAULT --title "$ENCR_SUBKEY_EXPIRY_TITLE_EN" 3>&1 1>&2 2>&3)
fi

# SIGNING SUBKEY
if (whiptail --yesno "$SIGN_SUBKEY_YESNO_TEXT_EN" 8 78 --title "$SIGN_SUBKEY_YESNO_TITLE_EN") then
	SIGN_SUBKEY=$(whiptail --inputbox "$SIGN_SUBKEY_TEXT_EN" 15 78 $SUBKEY_ALGO_DEFAULT --title "$SIGN_SUBKEY_TITLE_EN" 3>&1 1>&2 2>&3)
	SIGN_SUBKEY_EXPIRY=$(whiptail --inputbox "$EXPIRY_TEXT_EN" 15 78 $SUBKEY_EXPIRY_DEFAULT --title "$SIGN_SUBKEY_EXPIRY_TITLE_EN" 3>&1 1>&2 2>&3)
fi

# AUTHENTICATION SUBKEY
if (whiptail --yesno "$AUTH_SUBKEY_YESNO_TEXT_EN" 8 78 --title "$AUTH_SUBKEY_YESNO_TITLE_EN") then
	AUTH_SUBKEY=$(whiptail --inputbox "$AUTH_SUBKEY_TEXT_EN" 15 78 $SUBKEY_ALGO_DEFAULT --title "$AUTH_SUBKEY_TITLE_EN" 3>&1 1>&2 2>&3)
	AUTH_SUBKEY_EXPIRY=$(whiptail --inputbox "$EXPIRY_TEXT_EN" 15 78 $SUBKEY_EXPIRY_DEFAULT --title "$AUTH_SUBKEY_EXPIRY_TITLE_EN" 3>&1 1>&2 2>&3)
fi