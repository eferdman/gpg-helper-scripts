#!/bin/bash
#
# quick_get_keys.sh: TUI for quick key creation
# asks for UID and passphrase

set -a
set -e

# Confirm Continue
whiptail_yesno "QUICK_GENERATE_TEXT" "QUICK_GENERATE_TITLE"
	
get_primary_uid

get_password