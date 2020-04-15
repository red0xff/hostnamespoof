#!/bin/sh
set -e
INSTALLDIR=/usr/share/hostnamespoof

if [ $(id -u) -ne "0" ]; then
	echo "Please run this program as root";
	exit 1;
fi

old_hostname=`cat /etc/hostname`;
hostname=`$INSTALLDIR/hostnamegen|sed s/\s//g`;

echo hostnamespoofer: setting hostname to $hostname | systemd-cat;
/usr/bin/hostnamectl set-hostname $hostname 2>&1 | systemd-cat;

sed -i "s/\b$old_hostname\b/$hostname/g" /etc/hosts
