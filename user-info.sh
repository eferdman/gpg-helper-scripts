#!/bin/bash

# user-info.sh gathers the user's uids and key preferences

set -a
set -e

#UIDS
PRIMARY_UID=$(whiptail --inputbox "Please enter your full name and email in the following format:\n Joe Tester <joe@tester.com>" 8 78 --title "Primary UID" 3>&1 1>&2 2>&3)

ADD_UIDS=$(whiptail --inputbox "Please enter any additional uids as a comma separated list.\nExample:\n  Barbara Streisand <barbara@streisand.com>, Barbara Streisand <barbara@beaches.com>" 15 78 --title "Additional UIDs" 3>&1 1>&2 2>&3)

#MASTER KEY
MASTER_KEY_ALGO=$(whiptail --inputbox "Please specify the algorithm for the primary key, followed by the desired key length, if applicable. Examples include rsa4096, dsa2048, ed25519 (or other ECC curves) for an ECC key, or accept the default." 15 78 rsa2048 --title "Primary Key Type" 3>&1 1>&2 2>&3)

MASTER_EXPIRY=$(whiptail --inputbox "Please specify how long the key should be valid.\n      0 = key does not expire\n    <n> = key expires in n days\n   <n>w = key expires in n weeks\n   <n>m = key expires in n months\n   <n>y = key expires in n years" 15 78 1y --title "Primary Key Expiration" 3>&1 1>&2 2>&3)

#SECONDARY KEY
SUBKEY_ALGO=$(whiptail --inputbox "Please specify the algorithm for the secondary (encryption) key, followed by length, if applicable. Examples include rsa2048, cv25519 for ECC, or other ECC curves" 15 78 rsa2048 --title "Encryption Subkey Algorithm" 3>&1 1>&2 2>&3)

SUBKEY_EXPIRY=$(whiptail --inputbox "Please specify how long the key should be valid.\n      0 = key does not expire\n    <n> = key expires in n days\n   <n>w = key expires in n weeks\n   <n>m = key expires in n months\n   <n>y = key expires in n years" 15 78 6m --title "Subkey Expiration" 3>&1 1>&2 2>&3)

#PASSWORD
while true
do
	PASSWORD=$(whiptail --passwordbox "Choose a Secure Password for Your Master Key" 8 78 --title "Password" 3>&1 1>&2 2>&3)
	
	CONF_PASSWORD=$(whiptail --passwordbox "Please Re-enter Your Password for Your Master Key" 8 78 --title "Password Confirmation" 3>&1 1>&2 2>&3)

	[ $PASSWORD = $CONF_PASSWORD ] && break
done

#ENCRYPTION SUBKEY
if (whiptail --yesno "Would you like to add an additional encryption subkey?" 8 78 --title "Additional Subkeys") then
	ENCR_SUBKEY=$(whiptail --inputbox "Please specify the algorithm for the encryption key, followed by length, if applicable.  Examples include rsa2048, cv25519 for ECC, or other ECC curves" 15 78 rsa2048 --title "Additional Encryption Subkey Algorithm" 3>&1 1>&2 2>&3)
	ENCR_SUBKEY_EXPIRY=$(whiptail --inputbox   "Please specify how long the key should be valid.\n      0 = key does not expire\n    <n> = key expires in n days\n   <n>w = key expires in n weeks\n   <n>m = key expires in n months\n   <n>y = key expires in n years" 15 78 1y --title "Additional Encryption Subkey Expiration" 3>&1 1>&2 2>&3)
fi

#SIGNING SUBKEY
if (whiptail --yesno "Would you like to add an additional signing subkey?" 8 78 --title "Additional Subkeys") then
        SIGN_SUBKEY=$(whiptail --inputbox "Please specify the algorithm for the encryption key, followed by length, if applicable.  Examples include rsa2048, ed25519 for ECC, or other ECC curves" 15 78 rsa2048 --title "Additional Signing Subkey Algorithm" 3>&1 1>&2 2>&3)
	SIGN_SUBKEY_EXPIRY=$(whiptail --inputbox "Please specify how long the key should be valid.\n      0 = key does not expire\n    <n> = key expires in n days\n   <n>w = key expires in n weeks\n   <n>m = key expires in n months\n   <n>y = key expires in n years" 15 78 1y --title "Additional Signing Subkey Expiration" 3>&1 1>&2 2>&3)
fi

#AUTHENTICATION SUBKEY
if (whiptail --yesno "Would you like to add an authentication subkey?" 8 78 --title "Additional Subkeys") then
	AUTH_SUBKEY=$(whiptail --inputbox "Please specify the algorithm for the authentication subkey, followed by length, if applicable.  Examples include rsa2048, ed25519 for ECC, or other ECC curves" 15 78 rsa2048 --title "Authentication Subkey Algorithm" 3>&1 1>&2 2>&3)
	AUTH_SUBKEY_EXPIRY=$(whiptail --inputbox "Please specify how long the key should be valid.\n      0 = key does not expire\n    <n> = key expires in n days\n   <n>w = key expires in n weeks\n   <n>m = key expires in n months\n   <n>y = key expires in n years" 15 78 1y --title "Authentication Subkey Expiration" 3>&1 1>&2 2>&3)
fi
