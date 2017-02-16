#!/bin/bash
#
# set up environmental variables for internationalization

set -e
set -a 

# set environmental variables for internationalization
export TEXTDOMAINDIR=$HOME/gpg-helper-scripts/locale
export TEXTDOMAIN=ui-strings

# process the .po file into .mo file
msgfmt -o locale/en_US/LC_MESSAGES/ui-strings.mo po/en.po

# source helper files
. whiptail/whiptail_helper.sh

# call the main menu
. whiptail/main_menu.sh
