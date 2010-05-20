#!/bin/bash

usage="usage: $0 /path/to/pre-compiled/openvswitch/source/directory"

if [ -z $1 ]; then
  echo $usage
  exit 1
fi

cd `dirname $0`
cp ./bin/* /usr/local/bin/
mkdir -p /etc/ovs-testing/guest1
mkdir -p /etc/ovs-testing/guest2
echo '00:11:22:AA:BB:DD' > /etc/ovs-testing/guest1/mac_addr
echo '00:11:22:CC:AA:DD' > /etc/ovs-testing/guest2/mac_addr

cd $1
if [ ! -e datapath/linux-2.6/openvswitch_mod.ko ]; then
  echo 'Error: datapath/linux-2.6/openvswitch_mod.ko not found in open vSwitch sources'
  exit 1
else
  mkdir -p /usr/local/src/
  ln -s $1 /usr/local/src/ovs-src
fi
