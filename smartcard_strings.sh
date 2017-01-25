#!/bin/bash

# Whiptail TUI Strings for smartcard initialization

set -a

SMARTCARD_YESNO_TEXT_EN="Would you like to send your keys to a smartcard?"
SMARTCARD_YESNO_TITLE_EN="Smart Card"

SMARTCARD_INIT_YESNO_TEXT_EN="Would you like to initialize a smartcard with your name, language, and login?"
SMARTCARD_INIT_YESNO_TITLE_EN="Smart Card Initialization"
		
SMARTCARD_SURNAME_TEXT_EN="Please enter the Cardholder's Surname" 
SMARTCARD_SURNAME_TITLE_EN="Cardholder's Surname"

SMARTCARD_NAME_TEXT_EN="Please enter the Cardholder's First Name"
SMARTCARD_NAME_TITLE_EN="Cardholder's First Name"

SMARTCARD_LANG_TEXT_EN="Please enter the Preferred Language. E.g. en, fr, de"
SMARTCARD_LANG_TITLE_EN="Cardholder's Preferred Language"

SMARTCARD_LOGIN_TEXT_EN="Please enter the Cardholder's Login Name"
SMARTCARD_LOGIN_TITLE_EN="Cardholder's Login"

ADMIN_PIN_YESNO_TEXT_EN"=Would you like to set/change the Admin PIN of your smartcard?"
ADMIN_PIN_YESNO_TITLE_EN="Change Admin PIN"

OLD_ADMIN_PIN_TEXT_EN="Please enter the old Admin PIN (default is 12345678)"
OLD_ADMIN_PIN_DEFAULT="12345678"
OLD_ADMIN_PIN_TITLE_EN="Old Admin PIN"
OLD_ADMIN_PIN_CONF_TEXT_EN="Please re-enter your old Admin PIN"
OLD_ADMIN_PIN_CONF_TITLE_EN="Verify Old Admin PIN"

NEW_ADMIN_PIN_TEXT_EN="Please enter the new Admin PIN"
NEW_ADMIN_PIN_TITLE_EN="New Admin PIN"
NEW_ADMIN_PIN_CONF_TEXT_EN="Please re-enter the new Admin PIN"
NEW_ADMIN_PIN_CONF_TITLE_EN="Verify New Admin PIN"

USER_PIN_YESNO_TEXT_EN="Would you like to set/change the User PIN on your smartcard?"
USER_PIN_YESNO_TITLE_EN="Change User PIN"

OLD_USER_PIN_TEXT_EN="Please enter the old User PIN (default is 123456)"
OLD_USER_PIN_DEFAULT="123456"
OLD_USER_PIN_TITLE_EN="Old User PIN"
OLD_USER_PIN_CONF_TEXT_EN="Please re-enter your old User PIN"
OLD_USER_PIN_CONF_TITLE_EN="Verify Old User PIN"

NEW_USER_PIN_TEXT_EN="Please enter the new PIN"
NEW_USER_PIN_TITLE_EN="New PIN"
NEW_USER_PIN_CONF_TEXT_EN="Please re-enter the new PIN"
NEW_USER_PIN_CONF_TITLE_EN="Verify New PIN"

RESET_CODE_YESNO_TEXT_EN="Would you like to set the reset code for your smartcard?"
REET_CODE_YESNO_TITLE_EN="Set Reset Code"

RESET_CODE_TEXT_EN="Please enter the new Reset Code"
RESET_CODE_TITLE_EN="New Reset Code"
RESET_CODE_CONF_TEXT_EN="Please re-enter the new Reset Code"
RESET_CODE_CONF_TITLE_EN="Verify New Reset Code"