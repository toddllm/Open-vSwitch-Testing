#!/bin/bash

usage="usage: $0 /path/to/pre-compiled/openvswitch/source/directory"

if [ -z $1 ]; then
  echo $usage
  exit 1
fi

user=`whoami`
if [ $user != "root" ]; then
  echo 'must be root'
  exit 1
fi

cd `dirname $0`
cp ./bin/* /usr/local/bin/
mkdir -p /usr/local/etc/ovs-testing/guests/guest1
mkdir -p /usr/local/etc/ovs-testing/guests/guest2
echo '00:11:22:AA:BB:DD' > /usr/local/etc/ovs-testing/guests/guest1/mac_addr
echo '00:11:22:CC:AA:DD' > /usr/local/etc/ovs-testing/guests/guest2/mac_addr

mkdir -p /usr/local/etc/ovs-testing/guests/guest1/copy_into_filesystem/etc/network
mkdir -p /usr/local/etc/ovs-testing/guests/guest2/copy_into_filesystem/etc/network
cat > /usr/local/etc/ovs-testing/guests/guest1/copy_into_filesystem/etc/network/interfaces <<EOT
auto lo
iface lo inet loopback

auto eth0 
iface eth0 inet static
address 10.0.0.201
netmask 255.255.255.0 
EOT

echo '10.0.0.201' > /usr/local/etc/ovs-testing/guests/guest1/ip

cat > /usr/local/etc/ovs-testing/guests/guest2/copy_into_filesystem/etc/network/interfaces <<EOT
auto lo
iface lo inet loopback

auto eth0 
iface eth0 inet static
address 10.0.0.202
netmask 255.255.255.0 
EOT

echo '10.0.0.202' > /usr/local/etc/ovs-testing/guests/guest2/ip

mkdir -p /usr/local/etc/
cp ./etc/* /usr/local/etc/

cd $1
if [ ! -e datapath/linux-2.6/openvswitch_mod.ko ]; then
  echo 'Error: datapath/linux-2.6/openvswitch_mod.ko not found in open vSwitch sources'
  exit 1
else
  mkdir -p /usr/local/src/
  ln -sf $1 /usr/local/src/ovs-src
fi



