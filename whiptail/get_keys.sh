#!/bin/bash
#
# get-keys.sh gathers the user's uids and key preferences

set -a
set -e

get_uids

get_primary_key_prefs

get_subkey_prefs

get_password

	