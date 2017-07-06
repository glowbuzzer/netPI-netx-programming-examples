## netPI 
### Industrialized Raspberry Pi for Custom Automation Projects

For platform details read on [here](https://www.netiot.com/netpi/)

### The image - Raspbian OS with netX programming examples

Base of this image builds a [Raspbian OS](https://hub.docker.com/r/resin/rpi-raspbian/tags/) with enabled [SSH](https://en.wikipedia.org/wiki/Secure_Shell)
 and created user 'pi'.

Additionally the image provides netX programming examples in source code and as executables for 

* PROFINET IO device 
* EtherNet/IP adapter

#### Container prerequisites

##### Port mapping

For remote login to the container across SSH the container's SSH port `22` needs to be mapped to any free netPI host port.

##### Host device

To allow applications in the container the access to the netX the netPI host device `/dev/spidev0.0` needs to be exposed to the container.

#### Getting started

STEP 1. Open netPI's landing page under `https://<netpi's ip address>`.

STEP 2. Click the Docker tile to open the [Portainer.io](http://portainer.io/) Docker management user interface.

STEP 3. Enter the following parameters under **Containers > Add Container**

* **Image**: `hilschernetpi/netpi-netx-programming-examples`

* **Port mapping**: `Host "22" (any unused one) -> Container "22"` 

* **Restart policy"** : `always`

* **Runtime > Devices > add device**: `Host "/dev/spidev0.0" -> Container "/dev/spidev0.0"`

STEP 4. Press the button **Actions > Start container**

Pulling the image from Docker Hub may take up to 5 minutes.

#### Accessing

After the container has been started login to it with a SSH client such as [putty](http://www.putty.org/) using the netPI's IP address along with the mapped SSH port. Use the credentials `pi` as user and `raspberry` as password when asked and you are logged in as a non-root user `pi`.

##### The programming example files and folders

The login directs you to the user's home directory /home/pi with following structure

```
/home/pi/
       |
       +--/devicedescriptions   - device description files such as EDS, GSDML needed for master engineering
       +--/driver               - netX driver installation package
       +--/firmwares            - netX firmware installation packages
       +--/includes             - protocol specific include files for compilation
       +--/manuals              - common cifX API manual and protocol specific API manuals
       +--/objs                 - folder where the object files of the compilation process are stored to
       +--/sources              - protocol specific source codes of the demos
       | Makefile               - Makefile to compile example applications using 'make' command
       | PNS_simpleConfig       - precompiled and executable PROFINET example 
       | EIS_simpleConfig       - precompiled and executable EtherNet/IP example
```
##### netX driver installation

To install the netX SPI driver package move to the `driver` folder and call 

`dpkg -i netx-drv-1.1.0.deb`

The driver will be installed into the folder `/opt/cifx`. 

The cifX API function library needed for linking will be installed into folder `/usr/lib`. 

Basic include files needed for the compilation process will be installed into folder `/usr/include`.

##### netX firmware installation

To install a firmware package move to the folder `firmwares` and call

* `dpkg -i netpi-pns-3.12.0.2.deb` for PROFINET IO device firmware    
* `dpkg -i netpi-eis-2.12.5.0.deb` for EtherNet/IP adapter firmware

Any firmware package extracts its firmware into the folder `/opt/cifx/deviceconfig/FW/channel0`. 

The firmware will be loaded by the driver into netX the next time the driver is accessed with `cifXDriverInit()` command.

There can be only one installed firmware package at a time. An existing package will be automatically uninstalled during installation.

##### Compiling the programming examples

To compile the programming examples simply call `make` in the pi home directory. The command will locate the `Makefile` which initiates the compilation process and checks the depencencies.

The following executables will be compiled

* `PNS_simpleConfig` as PROFINET IO device demo
* `EIS_simpleConfig` as EtherNet/IP adapter demo

You may be faced with the following warning during compilation process

`make: warning:  Clock skew detected.  Your build may be incomplete.`

There is a discrepancy between netPI's system clock and the time the executeables/object files have been generated. Call `make clean` and remove the executeable. Then start the compilation process again. Make also sure you have set netPI's system clock correctly.

##### Starting the executables

To start the compiled examples call the following executeables in the pi home directory

* `sudo ./PNS_simpleConfig` for the PROFINET IO device example
* `sudo ./EIS_simpleConfig` for the EtherNet/IP adapter example

The examples check if the corresponding firmware package has been installed properly, if not they install it automatically.

##### Linking the cifX library to applications

To link the cifX driver library to own applications at later times just add the option `-lcifx` to your GCC compilation command or in your makefile.

##### The cifX API reference (netX driver API)

The cifX driver function API is described in the manual 

`cifX_API_PR_04_EN.pdf` 

located in the `manuals` folder.

##### The protocol specific APIs (PROFINET, EtherNet/IP ... APIs)

A netX firmware has a common part that is behaving the same for all firmwares and a protocol dependent specific part. Particularly the configuration varies from protocol to protocol and shows different characteristics.

The protocol specific dependencies are described in these manuals

* `PROFINET_IO-Device_V3.12_Protocol_API_17_EN.pdf` for PROFINET IO device 
* `EtherNetIP_Adapter_Protocol_API_19_EN.pdf` for EtherNet/IP adapter

located in the `manuals` folder.

#### GitHub sources
The image is built from the GitHub project [netPI-netx-programming-examples](https://github.com/Hilscher/netPI-netx-programming-examples). It complies with the [Dockerfile](https://docs.docker.com/engine/reference/builder/) method to build a Docker image [automated](https://docs.docker.com/docker-hub/builds/).

To allow building ARM containers on x86 platforms under [Dockerhub](https://hub.docker.com/) the Dockerfile uses the method described here [resin.io](https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/).

### References:

* https://www.netiot.com/netpi/
* https://hub.docker.com/r/resin/rpi-raspbian/tags/)
* https://en.wikipedia.org/wiki/Secure_Shell
* http://portainer.io/
* https://www.raspberrypi.org/downloads/raspbian/
* http://www.putty.org/
* https://github.com/Hilscher/netPI-netx-programming-examples
* https://docs.docker.com/engine/reference/builder/
* https://hub.docker.com/
* https://resin.io/blog/building-arm-containers-on-any-x86-machine-even-dockerhub/

[![N|Solid](http://www.hilscher.com/fileadmin/templates/doctima_2013/resources/Images/logo_hilscher.png)](http://www.hilscher.com)  Hilscher Gesellschaft für Systemautomation mbH  www.hilscher.com

