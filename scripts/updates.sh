#!/bin/sh
# For use with i3blocks
echo "Checking for updates..."
dnf check-update > /dev/null
case $? in
	0) # No updates
	echo "Up to date"
	sleep 1
	echo
	exit 0
	;;

	100) # Updates available
	echo "Updates available"
	exit 0
	;;

	1) # Error checking updates
	echo "Error checking updates"
	exit 33 # set i3blocks urgent flag
	;;
esac

