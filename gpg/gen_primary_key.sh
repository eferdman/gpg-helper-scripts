#!/bin/bash
#
# Generate primary key

set -e

MASTER_KEY_USAGE=${1:--} 

echo "Generating the master key..."
gpg --batch --passphrase $PASSWORD \
--quick-gen-key $PRIMARY_UID \
$MASTER_KEY_ALGO $MASTER_KEY_USAGE $MASTER_EXPIRY

echo "Adding any additional UIDs..."
python add-uids.py