ARG UBUNTU_VERSION

FROM ubuntu:$UBUNTU_VERSION

ARG DPDK_VERSION
ARG DPDK_STUFF=dpdk-$DPDK_VERSION.tar.xz
ARG DPDK_HOME=/dpdk

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       build-essential \
       ca-certificates \
       libnuma-dev \
       python3-pip \
       python3-pyelftools \
       python3-setuptools \
       wget \
       xz-utils \
       net-tools \
       pciutils \
       iproute2 \
       sudo \
       ethtool \
       lshw \
  && pip3 install \
       meson \
       ninja \
  && wget --quiet http://fast.dpdk.org/rel/$DPDK_STUFF \
  && mkdir --parents $DPDK_HOME \
  && tar --extract --file=$DPDK_STUFF --directory=$DPDK_HOME --strip-components 1 \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm --force $DPDK_STUFF

RUN cd $DPDK_HOME && meson -Dexamples=all build && ninja -C build && ldconfig

#USER root


############################################### HUGE PAGES

# below does not work
#RUN mkdir dev/hugepages \
#	&& chmod 777 dev/hugepages \
#	&& ls -l /sys/devices/system/node/node0/hugepages
	#&& mount -t hugetlbfs nodev dev/hugepages \
	#&& chmod 777 /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages \
	#&& echo 64 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages


############################################### NIC BIND

# docker run --cap-add=NET_ADMIN --privileged -dit dpdk-img:dpdk-23.03-ubuntu-20.04
# docker exec -it <container> /bin/sh
# su 
# ip link
# ip link set eth0 down
# cd /dpdk/usertools
# ./dpdk-devbind.py --status 
#  echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
# ./dpdk-devbind.py --bind=vfio-pci 00:03.0 # may require sudo
# 

# below most likey dows not work

#RUN cd $DPDK_HOME/usertools
#RUN sudo ifconfig enp0s3 down # todo name
#RUN ./dpdk-devbind.py -u 00:03.0 # todo name
#RUN chmod 777 /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
#RUN echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
#RUN ./dpdk-devbind.py --bind=vfio-pci 00:03.0


#ENV RTE_SDK=$DPDK_HOME

#ENV RTE_SDK=$DPDK_HOME