#!/bin/bash
#
# Print the paper key and revocation certificate

# Print the Paper Key time stamped with fingerprint.
gpg-key2ps -s -p a4 $PRIMARY_UID > ~/paper-key.ps

# Print the Revocation Certificate
# print ~/.gnupg/openpgp-revocs.d/$FPR.rev
