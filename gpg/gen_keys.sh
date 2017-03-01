#!/bin/bash
#
# Generate primary and subkeys with custom preferences

set -e

./gen_primary_key.sh $MASTER_KEY_USAGE

# Grab Fingerprint
FPR=$(gpg --with-colons --fingerprint | awk -F: '$1 == "fpr" {print $10;}')

echo "Generating the secondary key..."
gpg --quick-addkey $FPR $SUBKEY_ALGO encrypt $SUBKEY_EXPIRY

