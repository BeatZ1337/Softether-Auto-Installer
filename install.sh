#!/bin/sh

printf "\033[1;95mThis script will auto install SoftEther And Do Everything For You\033[1;97m \n";
printf "\033[1;96mBeatZVPN ( :\033[1;97m \n";
sleep 5;

apt-get update -y >/dev/null;

printf "\033[1;92mUpdate Done.\033[1;97m \n";
sleep 5;

apt-get remove apt-listchanges -y >/dev/null;
apt-get upgrade -y >/dev/null;

printf "\033[1;92mUpgrade Done.\033[1;97m \n";
sleep 5;

apt-get install checkinstall -y >/dev/null;
apt-get install build-essential -y >/dev/null;

printf "\033[1;92mDependencies Done.\033[1;97m \n";
sleep 5;

wget https://www.softether-download.com/files/softether/v4.24-9652-beta-2017.12.21-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x64-64bit.tar.gz -o /dev/null;
tar -xsf softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x64-64bit.tar.gz > /dev/null;
rm -rf softether-vpnserver-v4.24-9652-beta-2017.12.21-linux-x64-64bit.tar.gz;

printf "\033[1;92mFetched and Tar SoftEther.\033[1;97m \n";
sleep 5;


(cd vpnserver && (printf '1\n';sleep 1;printf '1\n';sleep 1;printf '1\n';sleep 1;) | make) >/dev/null
printf "\033[1;92mOpenVPN Done.\033[1;97m \n";
sleep 5;

cd;
mv vpnserver/ /usr/local;
printf "\033[1;92mMoved Folder.\033[1;97m \n";
sleep 5;
chmod 600 * /usr/local/vpnserver/;
chmod 700 /usr/local/vpnserver/vpnserver && chmod 700 /usr/local/vpnserver/vpncmd;

printf "\033[1;92mPermissions Given.\033[1;97m \n";
sleep 5;

echo '#!/bin/sh
# description: SoftEther VPN Server
### BEGIN INIT INFO
# Provides:          vpnserver
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: softether vpnserver
# Description:       softether vpnserver daemon
### END INIT INFO
DAEMON=/usr/local/vpnserver/vpnserver
LOCK=/var/lock/subsys/vpnserver
test -x $DAEMON || exit 0
case "$1" in
start)
$DAEMON start
touch $LOCK
;;
stop)
$DAEMON stop
rm $LOCK
;;
restart)
$DAEMON stop
sleep 3
$DAEMON start
;;
*)
echo "Usage: $0 {start|stop|restart}"
exit 1
esac
exit 0' > /etc/init.d/vpnserver;
printf "\033[1;92mScript Ran.\033[1;97m \n";
sleep 5;

chmod 755 /etc/init.d/vpnserver;
update-rc.d vpnserver defaults;

printf "\033[1;92mIt will start on boot.\033[1;97m \n";
sleep 5;

/etc/init.d/vpnserver start;
printf "\033[32;5mSoftether Installed Sucessfully By BeatZ.\033[0m \n";

