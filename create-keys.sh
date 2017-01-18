#!/bin/bash

set -e

# Grab the user's information and preferences
. user-info.sh

echo "Generating the master key..."
gpg2 --batch --passphrase $PASSWORD --pinentry-mode=loopback --quick-gen-key $PRIMARY_UID $MASTER_KEY_ALGO - $MASTER_EXPIRY

echo "Generating the secondary key..."
FPR=$(gpg2 --with-colons --fingerprint | awk -F: '$1 == "fpr" {print $10;}')
gpg2 --quick-addkey $FPR $SUBKEY_ALGO encrypt $SUBKEY_EXPIRY

echo "Adding any additional UIDs..."
python add-uids.py

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
. smartcard-init.sh

# TODO: Initialize Smart Card

# TODO: Send Keys to Card

# Copy public key to /tmp
cp -a ~/.gnupg/pubring.gpg /tmp