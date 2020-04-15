set -e

INSTALLDIR=/usr/share/hostnamespoof
if [ "$#" -ne "1" ]; then
	echo "usage: $0 <filename>";
	echo "filename: path to the executable that generates random hostnames (note: refer to valid Linux hostnames, or to the example hostname generators available with this project)"
else
	if [ "$(id -u)" -ne "0" ]; then
		echo "Please run this script as root";
		exit 1;
	fi
	if [ ! -f $1 ]; then
		echo "$1 : no such file or directory";
		exit 1;
	fi
	mkdir $INSTALLDIR || true;
	cp $1 $INSTALLDIR/hostnamegen;
	if [ "$(sha256sum 'spoof_hostname.sh'|head -c64)" != "776069ad8df19d66fcff5694a58f28d256950f68ada813d3a2e5a53bf2e3b7b1" ]; then
		echo "Checksum of spoof_hostname.sh doesn't match, make sure you know what you are doing";
		exit 1;
	fi
	cp spoof_hostname.sh $INSTALLDIR/;
	chmod 755 $INSTALLDIR/*;
	echo ;
	read -p "Do you want to install it as a systemd service also? (Y/N)" userinput;
	echo;
	echo "$userinput" | grep -i "^[^y]" >/dev/null && exit 0;
		# install as systemd service
	if [ "$(sha256sum 'hostnamespoof.service'|head -c64)" != "57664e42636b61974a7f7230226e723262ecc2ee7d861f9e368ec11945bf421c" ]; then
		echo "Checksum of hostnamespoof.service doesn't match, make sure you know what you are doing";
		exit 1;
	fi
	cp hostnamespoof.service /etc/systemd/system/;
	systemctl daemon-reload;
	systemctl enable hostnamespoof.service;
	systemctl start hostnamespoof.service;
fi
