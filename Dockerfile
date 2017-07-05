#take a fixed raspbian version
FROM resin/rpi-raspbian:jessie-20170531

#set prerequisites to compile ARM code on x86 machines during automated build
ENV QEMU_EXECVE 1
COPY armv7hf-debian-qemu /usr/bin
RUN [ "cross-build-start" ]

USER root

#labeling
LABEL maintainer="netpi@hilscher.com" \
      version="V0.9.0.0" \
      description="Raspbian OS with netX programming examples"

#version
ENV HILSCHERNETPI_NETX_PROGRAMMING_EXAMPLES_VERSION 0.9.0.0

#install ssh, gcc, create user "pi" and make him sudo
RUN apt-get update  \
    && apt-get install -y openssh-server build-essential \
    && mkdir /var/run/sshd \
    && useradd --create-home --shell /bin/bash pi \
    && echo 'pi:raspberry' | chpasswd \
    && adduser pi sudo 
    
#create needed folders
RUN mkdir /home/pi/manuals /home/pi/firmwares /home/pi/driver /home/pi/includes /home/pi/sources \
          /home/pi/includes/EtherNetIP /home/pi/includes/PROFINET /home/pi/includes/EtherCAT \
          /home/pi/devicedescriptions/ /home/pi/devicedescriptions/PROFINET /home/pi/devicedescriptions/EtherNetIP /home/pi/objs

#set the working directory
WORKDIR /home/pi

#copy the manuals
COPY files-to-copy-to-image/manuals/* manuals/

#copy the firmware packages
COPY files-to-copy-to-image/firmwares/* firmwares/

#copy the netx driver
COPY files-to-copy-to-image/driver/* driver/

#copy the include files
COPY files-to-copy-to-image/includes/EtherNetIP/* includes/EtherNetIP/
COPY files-to-copy-to-image/includes/PROFINET/* includes/PROFINET/
COPY files-to-copy-to-image/includes/SystemPackets.h includes/
COPY files-to-copy-to-image/includes/App.h includes/
COPY files-to-copy-to-image/includes/PacketHandlerPNS.h includes/
COPY files-to-copy-to-image/includes/PacketHandlerEIS.h includes/

#copy the device description files such as GSDML, EDS
COPY devicedescriptions/PROFINET/* devicedescriptions/PROFINET/
COPY devicedescriptions/EtherNetIP/* devicedescriptions/EtherNetIP/

#copy the makefile and the application source codes
COPY files-to-copy-to-image/Makefile ./
COPY files-to-copy-to-image/sources/* sources/

#install the driver
RUN dpkg -i ./driver/netx-drv-1.1.0.deb

#compile the applications
RUN make

#SSH port
EXPOSE 22

#the entrypoint shall start ssh
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

RUN [ "cross-build-end" ]
