#!/bin/bash

cd `dirname $0`
cp ./bin/* /usr/local/bin/
mkdir -p /etc/ovs-testing/guest1
mkdir -p /etc/ovs-testing/guest2
echo '00:11:22:AA:BB:DD' > /etc/ovs-testing/guest1/mac_addr
echo '00:11:22:CC:AA:DD' > /etc/ovs-testing/guest2/mac_addr

