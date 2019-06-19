#!/bin/bash

case "$1" in
	show)
		gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
		gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
		;;

	hide)
		gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
		gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
		gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
		;;

	*)
		echo "Usage $0 {hide/show}"
		exit 1
esac

exit 0
