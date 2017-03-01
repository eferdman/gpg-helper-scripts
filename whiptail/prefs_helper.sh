#!/bin/bash
#
# key preferences helper functions

get_add_uids() {
	whiptail_input "ADD_UIDS"
}

get_primary_uid() {
	whiptail_input "PRIMARY_UID"
}

get_uids() {
	get_primary_uid
	get_add_uids
}

# User chooses an rsa4096 or ECC key,
# Usage: cert/sign or cert only
# Expiration
get_primary_key_prefs() {
	whiptail_radio "MASTER_KEY_ALGO" \
	"RSA" "ECC"
	if [[ $MASTER_KEY_ALGO = "ECC" ]]; then
		whiptail_radio "ECC_CURVE" \
		"ed25519" \
		"nistp256" \
		"nistp384" \
		"nistp521" \
		"brainpoolP256r1" \
		"brainpoolP384r1" \
		"brainpoolP512r1" \
		"secp256k1"
		MASTER_KEY_ALGO=$ECC_CURVE
	else
		MASTER_KEY_ALGO=$MASTER_KEY_ALGO_DEFAULT
	fi
	# Prompt user for usage
	whiptail_radio "MASTER_KEY_USAGE" \
	"Certification/Signing" "Certification Only"
	if [[ $MASTER_KEY_USAGE = "Certification/Signing" ]]; then
		MASTER_KEY_USAGE="sign"
	else
		MASTER_KEY_USAGE="cert"
	fi
	# Prompt user for Expiry
	get_expiry "MASTER_KEY_EXPIRY"
}

# Secondary Key Preferencse
get_subkey_prefs() {
	# ask for rsa or ecc
		# if rsa prompt for length & validate
	whiptail_radio "SUBKEY_ALGO" "RSA" "ECC"
	if [[ $SUBKEY_ALGO = "ECC" ]]; then
		whiptail_radio "ECC_CURVE" \
		"cv25519" \
		"nistp256" \
		"nistp384" \
		"nistp521" \
		"brainpoolP256r1" \
		"brainpoolP384r1" \
		"brainpoolP512r1" \
		"secp256k1"
		SUBKEY_ALGO=$ECC_CURVE
	else
		while true; do
			whiptail_input "RSA_SUBKEY_LENGTH" "SUBKEY_LENGTH_DEFAULT"
			[ $RSA_SUBKEY_LENGTH -ge 2048 ] && [ $RSA_SUBKEY_LENGTH -le 4096 ] && break
		done
		SUBKEY_LENGTH=$RSA_SUBKEY_LENGTH
		SUBKEY_ALGO="rsa$SUBKEY_LENGTH"
	fi
	get_expiry "SUBKEY_EXPIRY"
}

# Validate that password is 12 chars and confirm password
get_password() {
	while true
	do
		while true
		do
			whiptail_password "PASSWORD"
			[ ${#PASSWORD} -ge 12 ] && break
		done
		whiptail_password "CONF_PASSWORD"
		[ $PASSWORD = $CONF_PASSWORD ] && break
	done
}
# confirm passwords for smartcard pins
confirm_password() {
	while true
	do
		whiptail_password $1

		whiptail_password $2

		[ ${!1} = ${!2} ] && break
	done
}
