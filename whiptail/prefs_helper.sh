get_add_uids() {
	whiptail_input "ADD_UIDS"
}

get_primary_uid() {
	whiptail_input "PRIMARY_UID"
}

get_uids() {
	get_primary_uid
	get_add_uids
}

get_primary_key_prefs() {
	# MASTER KEY
	whiptail_input "MASTER_KEY_ALGO"
	get_expiry "MASTER_KEY_EXPIRY"
}

get_subkey_prefs() {
	whiptail_input "SUBKEY_ALGO"
	get_expiry "SUBKEY_EXPIRY"
}

# Validate that password is 12 chars and confirm password
get_password() {
	while true
	do
		while true
		do
			whiptail_password "PASSWORD"
			[ ${#PASSWORD} -ge 12 ] && break
		done
		whiptail_password "CONF_PASSWORD"
		[ $PASSWORD = $CONF_PASSWORD ] && break
	done
}
# confirm passwords for smartcard pins
confirm_password() {
	while true
	do
		whiptail_password $1

		whiptail_password $2

		[ ${!1} = ${!2} ] && break
	done
}
