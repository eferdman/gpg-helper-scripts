#!/bin/bash
#
# Generate primary and subkeys

set -e

# Grab the user's information and preferences
. whiptail/gen_keys.sh

echo "Generating the master key..."
gpg2 --batch --passphrase $PASSWORD --quick-gen-key $PRIMARY_UID $MASTER_KEY_ALGO - $MASTER_EXPIRY

echo "Adding any additional UIDs..."
python add-uids.py