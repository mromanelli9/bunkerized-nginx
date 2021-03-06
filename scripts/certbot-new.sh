#!/bin/sh

# generate certificate
certbot certonly --webroot -w /acme-challenge -n -d "$1" --email "$2" --agree-tos
if [ "$?" -ne 0 ] ; then
	exit 1
fi

exit 0
