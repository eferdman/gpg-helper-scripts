#!/bin/bash
# 
# get_subkey.sh: TUI for quick key creation
# asks for UID and passphrase

# Prompt for algo (radio):
# DSA, RSA, ELG, ECC
whiptail_radio "CUSTOM_SUBKEY_ALGO" "RSA" "DSA" "ELG (Encryption)" "ECC"

# if DSA, RSA, ELG
if ! [[ $CUSTOM_SUBKEY_ALGO = "ECC" ]]; then
	# Prompt user for usage (checkbox) and length (input)
	# TODO: validate length
	if [[ $CUSTOM_SUBKEY_ALGO = "DSA" ]]; then
		# Prompt user for usage (checkbox)
		whiptail_checkbox "SUBKEY_USAGE" \
		"sign" "auth"
		while true; do
			whiptail_input "DSA_SUBKEY_LENGTH" "SUBKEY_LENGTH_DEFAULT"
			[ $DSA_SUBKEY_LENGTH -ge 2048 ] && [ $DSA_SUBKEY_LENGTH -le 3072 ] && break
		done
		SUBKEY_LENGTH=$DSA_SUBKEY_LENGTH
		CUSTOM_SUBKEY_ALGO="dsa"
	elif [[ $CUSTOM_SUBKEY_ALGO = "RSA" ]]; then
		whiptail_checkbox "SUBKEY_USAGE" \
		"sign" "auth" "encrypt"
		while true; do
			whiptail_input "RSA_SUBKEY_LENGTH" "SUBKEY_LENGTH_DEFAULT"
			[ $RSA_SUBKEY_LENGTH -ge 2048 ] && [ $RSA_SUBKEY_LENGTH -le 4096 ] && break
		done
		SUBKEY_LENGTH=$RSA_SUBKEY_LENGTH
		CUSTOM_SUBKEY_ALGO="rsa"
	else 
		while true; do
			whiptail_input "ELG_SUBKEY_LENGTH" "SUBKEY_LENGTH_DEFAULT"
			[ $ELG_SUBKEY_LENGTH -ge 2048 ] && [ $ELG_SUBKEY_LENGTH -le 4096 ] && break
		done
		SUBKEY_LENGTH=$ELG_SUBKEY_LENGTH
		CUSTOM_SUBKEY_ALGO="elg"
		SUBKEY_USAGE="encrypt"
	fi
else
	# Prompt user for usage (radio):
	whiptail_radio "SUBKEY_USAGE" \
	"encrypt" "sign" "auth" "sign,auth"
	# Prompt user for ECC curve (radio):
	if [[ $SUBKEY_USAGE = "encrypt" ]]; then
		whiptail_radio "ECC_CURVE" \
		"cv25519" \
		"nistp256" \
		"nistp384" \
		"nistp521" \
		"brainpoolP256r1" \
		"brainpoolP384r1" \
		"brainpoolP512r1" \
		"secp256k1"
	else
		whiptail_radio "ECC_CURVE" \
		"ed25519" \
		"nistp256" \
		"nistp384" \
		"nistp521" \
		"brainpoolP256r1" \
		"brainpoolP384r1" \
		"brainpoolP512r1" \
		"secp256k1"
	fi
	CUSTOM_SUBKEY_ALGO=$ECC_CURVE
fi

# Prompt user for expiry: input
get_expiry "SUBKEY_EXPIRY"

SUBKEY_USAGE=$(sed -e "s/\"//g"  -e "s/ /,/g" <<< $SUBKEY_USAGE)

SUBKEY_ALGO=$CUSTOM_SUBKEY_ALGO$SUBKEY_LENGTH

echo $SUBKEY_ALGO $SUBKEY_USAGE $SUBKEY_EXPIRY
