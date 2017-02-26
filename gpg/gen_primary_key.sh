#!/bin/bash
#
# Generate primary and subkeys

set -e

echo "Generating the master key..."
gpg --batch --passphrase $PASSWORD \
--quick-gen-key $PRIMARY_UID \
$MASTER_KEY_ALGO - $MASTER_EXPIRY

echo "Adding any additional UIDs..."
python add-uids.py