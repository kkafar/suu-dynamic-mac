#!bin/sh
# arg: NIC pattern

tmp=$(ip link | grep "$1" | head -1 | awk '{print $2}')
nic=${tmp%@*}
ip link set $nic down
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
cd /dpdk/usertools
