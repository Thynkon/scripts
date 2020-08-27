#!/usr/bin/env sh

DOWNLOAD_DIRECTORY="/tmp"
FIREFOX_DIRECTORY="/opt/firefox"
CURRENT_FIREFOX_VERSION=$(grep "BuildID" "${FIREFOX_DIRECTORY}/application.ini" | cut -d '=' -f 2)

main() {
	if [[ $EUID -ne 0 ]]; then
		echo "You must run this script as root!"
		echo "Exiting..."
		exit 1
	fi

	if [[ -f "${DOWNLOAD_DIRECTORY}/firefox/application.ini" ]]; then
		downloaded_firefox_version=$(grep "BuildID" "${DOWNLOAD_DIRECTORY}/firefox/application.ini" | cut -d '=' -f 2)
		if [[ $downloaded_firefox_version > $CURRENT_FIREFOX_VERSION ]]; then
			mv "${DOWNLOAD_DIRECTORY}/firefox" "${FIREFOX_DIRECTORY}"
			chown -R root:root "${FIREFOX_DIRECTORY}"
			echo "USING DOWNLOADED VERSION IN /TMP/FIREFOX"
			exit 0
		else
			echo "Deleting old firefox version"
			rm -r "${DOWNLOAD_DIRECTORY}/firefox"
		fi
	fi

	# stop any running instances of firefox
	pkill -f "firefox*"

	cd "${DOWNLOAD_DIRECTORY}"
	curl --location "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"  | tar --extract --verbose --preserve-permissions --bzip2

	if [[ -d "${FIREFOX_DIRECTORY}" ]]; then
		rm -r "${FIREFOX_DIRECTORY}"
	fi

	mv "${DOWNLOAD_DIRECTORY}/firefox" "${FIREFOX_DIRECTORY}"
	chown -R root:root "${FIREFOX_DIRECTORY}"
}

main $@
