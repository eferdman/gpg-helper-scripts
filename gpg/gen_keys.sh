#!/bin/bash
#
# Generate primary and subkeys

set -e

# Load helper scripts
. whiptail/whiptail_helper.sh

# Load environmental variables
. init.sh

# Grab the user's information and preferences
. whiptail/gen_keys.sh

echo "Generating the master key..."
gpg2 --batch --passphrase $PASSWORD --quick-gen-key $PRIMARY_UID $MASTER_KEY_ALGO - $MASTER_EXPIRY

# Set the primary UID
./set_primary_uid.sh

echo "Adding any additional UIDs..."
python add-uids.py

echo "Generating the secondary key..."
FPR=$(gpg2 --with-colons --fingerprint | awk -F: '$1 == "fpr" {print $10;}')
gpg2 --quick-addkey $FPR $SUBKEY_ALGO encrypt $SUBKEY_EXPIRY

echo "Generating additional signing, encryption and authentication subkeys"
if ! [ -z $SIGN_SUBKEY ];
then
	gpg2 --quick-addkey $FPR $SIGN_SUBKEY sign $SIGN_SUBKEY_EXPIRY;
fi

if ! [ -z $ENCR_SUBKEY ];
then
	gpg2 --quick-addkey $FPR $ENCR_SUBKEY encrypt $ENCR_SUBKEY_EXPIRY;
fi

if ! [ -z $AUTH_SUBKEY ];
then
	gpg2 --quick-addkey $FPR $AUTH_SUBKEY auth $AUTH_SUBKEY_EXPIRY;
fi

# Print the Paper Key time stamped with fingerprint.
gpg-key2ps -s -p a4 $PRIMARY_UID > ~/paper-key.ps

# Print the Revocation Certificate
# print ~/.gnupg/openpgp-revocs.d/$FPR.rev

# Grab Smartcard Initialization 
. whiptail/smartcard-init.sh

# TODO: Initialize Smart Card

# TODO: Send Keys to Card

# Copy public key to /tmp
cp -a ~/.gnupg/pubring.gpg /tmp