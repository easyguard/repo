#!/bin/sh
echo ' _____                 ____                     _ '
echo '| ____|__ _ ___ _   _ / ___|_   _  __ _ _ __ __| |'
echo '|  _| / _` / __| | | | |  _| | | |/ _` |  __/ _` |'
echo '| |__| (_| \__ \ |_| | |_| | |_| | (_| | | | (_| |'
echo '|_____\__,_|___/\__, |\____|\__,_|\__,_|_|  \__,_|'
echo '                |___/             INSTALLER'

echo Updating repositories
apk update
echo Installing required packages
apk add wget

echo Setting up repositories
cat > /etc/apk/repositories << EOF

https://dl-cdn.alpinelinux.org/alpine/v3.20/main/
https://dl-cdn.alpinelinux.org/alpine/v3.20/community/
https://easyguard.github.io/repo

EOF

echo Installing EasyGuard key
wget -O /etc/apk/keys/key.rsa.pub https://easyguard.github.io/repo/key.rsa.pub

echo Updating repositories
apk update
echo Installing utility packages
apk add nano

components="ezgapi ezgweb ezgdisp"
components_friendly="API Web-Interface S1-Display"
echo Selecting additional components to install

for i in $components; do
	echo "Install $i? [y/N]"
	read -r response
	if [ "$response" = "y" ]; then
		components_to_install="$components_to_install $i"
	fi
done

echo Installing EasyGuard components
apk add $components_to_install netd limes nftables blocky ezgdns busybox-extras

echo Configuring rc-update
# rc-update add failoverd
rc-update add netd
rc-update del networking boot
rc-update add nftables
rc-update add limes
rc-update add blocky

if echo $components_to_install | grep -q ezgapi; then
	rc-update add ezgapi
fi

if echo $components_to_install | grep -q ezgweb; then
	rc-update add lighttpd
	cat > /etc/lighttpd/lighttpd.conf << EOF
var.basedir = "/etc/easyguard-web"
var.logdir = "/var/log/lighttpd"
var.statedir = "/var/lib/lighttpd"
server.modules = (
	"mod_access",
	"mod_accesslog",
	"mod_auth",
	"mod_authn_file"
)
include "mime-types.conf"
server.username      = "lighttpd"                                                                                       
server.groupname     = "lighttpd"                                                                                       
                                                                               
server.document-root = var.basedir
server.pid-file      = "/run/lighttpd.pid"
server.errorlog      = var.logdir  + "/error.log"

index-file.names     = ("index.php", "index.html", "index.htm", "default.htm")

auth.backend = "htdigest"
auth.backend.htdigest.userfile = "/etc/lighttpd/lighttpd-htdigest.user"

auth.require = ( "/" =>
(
"method" => "digest",
"realm" => "EasyGuard",
"require" => "valid-user"
)
)
EOF
fi

if echo $components_to_install | grep -q ezgdisp; then
	rc-update add ezgdisp
fi

echo Configuring system
echo net.ipv4.ip_forward=1 > /etc/sysctl.conf
echo net.ipv6.conf.all.forwarding=1 >> /etc/sysctl.conf

echo Done. Please reboot your system.
echo Note: do not forget to save your overlay file system if you are using one.
echo You can do this by running "lbu ci".
