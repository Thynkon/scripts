#!/usr/bin/env sh

cd /tmp
curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"  | tar --extract --verbose --preserve-permissions --bzip2

if [[ -d /opt/firefox ]]; then
	rm -r /opt/firefox
fi

mv /tmp/firefox /opt/firefox
chown -R root:root /opt/firefox
