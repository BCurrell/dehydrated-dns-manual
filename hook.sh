#!/bin/bash

###
###

trap trap_int INT

trap_int()
{
	echo "Keyboard Interrupt! Stopping"
	exit 1
}

PREFIX="_acme-challenge"

deploy_challenge_single()
{
	local DOMAIN="${1}"
#	local TOKEN_FILENAME="${2}"
	local TOKEN_VALUE="${3}"

	local TOKEN_KEY="${PREFIX}.${DOMAIN}"

	local VERIFY=

	echo "Create a DNS record with the following information:"
	echo ""
	echo "Record Type:    TXT"
	echo "Record Name:    ${TOKEN_KEY}"
	echo "Record Value:   ${TOKEN_VALUE}"
	echo ""

	while [[ "${VERIFY}" != "yes" ]]
	do
		read -rp "Type 'yes' to continue: " VERIFY
	done
}

deploy_challenge()
{
	if (( "${#}" % 3 ))
	then
		echo "Invalid argument count, expected multiple of 3, got ${#}!"
		exit 1
	fi

	for (( a=1, b=2, c=3; c<="${#}"; a+=3, b+=3, c+=3 ))
	do
		deploy_challenge_single "${!a}" "${!b}" "${!c}"
	done
}

clean_challenge_single()
{
	local DOMAIN="${1}"
#	local TOKEN_FILENAME="${2}"
	local TOKEN_VALUE="${3}"

	local TOKEN_KEY="${PREFIX}.${DOMAIN}"

	local VERIFY=

	echo "Remove the DNS record with the following information:"
	echo ""
	echo "Record Type:    TXT"
	echo "Record Name:    ${TOKEN_KEY}"
	echo "Record Value:   ${TOKEN_VALUE}"
	echo ""

	while [[ "${VERIFY}" != "yes" ]]
	do
		read -rp "Type 'yes' to continue: " VERIFY
	done
}

clean_challenge()
{
	if (( "${#}" % 3 ))
	then
		echo "Invalid argument count, expected multiple of 3, got ${#}!"
		exit 1
	fi

	for (( a=1, b=2, c=3; c<="${#}"; a+=3, b+=3, c+=3 ))
	do
		clean_challenge_single "${!a}" "${!b}" "${!c}"
	done
}

ACTION="${1}"
shift

case "${ACTION}" in
	"deploy_challenge")
		deploy_challenge "${@}"
		;;
	"clean_challenge")
		clean_challenge "${@}"
		;;
esac
