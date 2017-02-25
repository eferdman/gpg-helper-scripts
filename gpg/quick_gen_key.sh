#!/bin/bash
#
# Default primary and subkey creation

set -e

echo "Generating the master key..."
gpg --batch --passphrase $PASSWORD \
--quick-gen-key $PRIMARY_UID \
$MASTER_ALGO_DEFAULT - $MASTER_EXPIRY_DEFAULT

# store fingerprint
FPR=$(gpg --with-colons --fingerprint | awk -F: '$1 == "fpr" {print $10;}')

echo "Generating the encryption subkey..."
gpg --quick-addkey $FPR \
$SUBKEY_ALGO_DEFAULT encrypt $SUBKEY_EXPIRY_DEFAULT

echo "Generating the signing subkey..."
gpg --quick-addkey $FPR \
$SUBKEY_ALGO_DEFAULT sign $SUBKEY_EXPIRY_DEFAULT

echo "Key Creation Complete."
gpg -k $FPR