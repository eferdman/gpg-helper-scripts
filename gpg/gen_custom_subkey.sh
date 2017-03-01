#!/bin/bash
#
# Generate custom subkey

gpg --quick-addkey $FPR $SUBKEY_ALGO $SUBKEY_USAGE $SUBKEY_EXPIRY
