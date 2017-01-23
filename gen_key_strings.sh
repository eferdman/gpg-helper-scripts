#!/bin/bash

# Whiptail TUI Strings for initial key generation

set -a
set -e

MASTER_KEY_ALGO_DEFAULT="rsa4096"
MASTER_EXPIRY_DEFAULT="1y"
SUBKEY_ALGO_DEFAULT="rsa2048"
SUBKEY_EXPIRY_DEFAULT="6m"
EXPIRY_TEXT_EN="Please specify how long the key should be valid.
	0 = key does not expire
	<n> = key expires in n days
	<n>w = key expires in n weeks
	<n>m = key expires in n months
	<n>y = key expires in n years"

PRIMARY_UID_TITLE_EN="Primary UID"
PRIMARY_UID_TEXT_EN="Please enter your full name and email in the following format:
Joe Tester <joe@tester.com>"

ADD_UIDS_TITLE_EN="Additional UIDs"
ADD_UIDS_TEXT_EN="Please enter any additional uids as a comma separated list.
Example:
  Barbara Streisand <barbara@streisand.com>, Barbara Streisand <barbara@beaches.com>"

MASTER_KEY_ALGO_TITLE_EN="Primary Key Algorithm"
MASTER_KEY_ALGO_TEXT_EN="Please specify the algorithm for the primary key, followed by the desired key length, if applicable.
Examples include rsa4096, dsa2048, ed25519 (or other ECC curves) for an ECC key, or accept the default."
MASTER_EXPIRY_TITLE_EN="Primary Key Expiration"

SUBKEY_ALGO_TITLE_EN="Encryption Subkey Algorithm"
SUBKEY_ALGO_TEXT_EN="Please specify the algorithm for the secondary (encryption) key, followed by length, if applicable.
Examples include rsa2048, cv25519 for ECC, or other ECC curves"
SUBKEY_EXPIRY_TITLE_EN="Subkey Expiration"

PASSWORD_TITLE_EN="Password"
PASSWORD_TEXT_EN="Choose a Password for Your Master Key (must be a minimum of 12 characters)"
CONF_PASSWORD_TITLE_EN="Password Confirmation"
CONF_PASSWORD_TEXT_EN="Please Re-enter Your Password for Your Master Key"

ENCR_SUBKEY_YESNO_TEXT_EN="Would you like to add an additional encryption subkey?"
ENCR_SUBKEY_YESNO_TITLE_EN="Additional Encryption Subkey"
ENCR_SUBKEY_TITLE_EN="Additional Encryption Subkey Algorithm"
ENCR_SUBKEY_TEXT_EN="Please specify the algorithm for the encryption key, followed by length, if applicable.
Examples include rsa2048, cv25519 for ECC, or other ECC curves"
ENCR_SUBKEY_EXPIRY_TITLE_EN="Additional Encryption Subkey Expiration"

SIGN_SUBKEY_YESNO_TEXT_EN="Would you like to add an additional signing subkey?"
SIGN_SUBKEY_YESNO_TITLE_EN="Additional Signing Subkey"
SIGN_SUBKEY_TITLE_EN="Additional Signing Subkey Algorithm"
SIGN_SUBKEY_TEXT_EN="Please specify the algorithm for the signing subkey, followed by length, if applicable.
Examples include rsa2048, ed25519 for ECC, or other ECC curves"
SIGN_SUBKEY_EXPIRY_TITLE_EN="Additional Signing Subkey Expiration"

AUTH_SUBKEY_YESNO_TEXT_EN="Would you like to add an authentication subkey?"
AUTH_SUBKEY_YESNO_TITLE_EN="Authentication Subkey"
AUTH_SUBKEY_TITLE_EN="Authentication Subkey Algorithm"
AUTH_SUBKEY_TEXT_EN="Please specify the algorithm for the authentication subkey, followed by length, if applicable.
Examples include rsa2048, ed25519 for ECC, or other ECC curves"
AUTH_SUBKEY_EXPIRY_TITLE_EN="Authentication Subkey Expiration"