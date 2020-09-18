#!/bin/bash

# Script Name: os-info.sh
# Description: show some info about PC and install software

#Check the root rights
chk_root() {
        local meid=$(id -u)
        if [ $meid -ne 0 ]; then
                echo "You must be root user to run this script"
                exit 999
        fi
}
chk_root

#Function mainmenu
function mainmenu () {
clear
TIME=1
echo " "
echo $0
echo " "
echo "Choose any options:

	1 - Check info about OS
	2 - Check info about CPU
	3 - Check info about HOSTNAME|IP|DNS|ROUTE
	4 - Check info about PORTS|IPTABLES
	5 - Check info about RAM
	6 - Scan space on /
	7 - Installed software
	8 - Installing programs
	0 - Exit"
echo " "
echo -n "Chosen option: "
read opcao
case $opcao in
	1)
		function osname () {

	echo "----------------------------------------------------------------"
	echo "			OS NAME"
	echo "----------------------------------------------------------------"

			# OS name
			OS_NAME=`cat /etc/os-release | grep -i ^PRETTY &&
			cat /etc/os-release | grep ^VERSION`

		if [ -f /etc/os-release ]
			then
				echo "$OS_NAME"
		fi

			# Kernel version
			#RED HAT: cat /etc/redhat-release
			KERNEL_VERSION_UBUNTU=`uname -r`
			KERNEL_VERSION_CENTOS=`uname -r`

		if [ -f /etc/lsb-release ]
			then
				echo "KERNEL_VERSION=$KERNEL_VERSION_UBUNTU"
			else
				echo "KERNEL_VERSION=$KERNEL_VERSION_CENTOS"
		fi

	echo "----------------------------------------------------------------"

	}
	osname
	read -n 1 -p "press <Enter> for main menu"
	mainmenu
	;;

	2)
		function cpuinfo () {

	echo "----------------------------------------------------------------"
	echo "			CPU INFO"
	echo "----------------------------------------------------------------"

			# CPU Model
			CPU_INFO=`cat /proc/cpuinfo | grep -i "^model name" | cut -d ":" -f2 | sed -n '1p'`
				echo "CPU model: $CPU_INFO"

			# CPU Temperatute
			TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

			ORIGINAL_TEMP=$(cat $TEMP_FILE)
			TEMP_C=$((ORIGINAL_TEMP/1000))
			TEMP_F=$(($TEMP_C * 9/5 + 32))
				echo "CPU temperature: $TEMP_C C"

	echo "----------------------------------------------------------------"

	}
	cpuinfo
	read -n 1 -p " press <Enter> for main menu"
	mainmenu
	;;

	3)
		function netstatus () {

	echo "----------------------------------------------------------------"
	echo "			HOSTNAME|IP|DNS|ROUTE"
	echo "----------------------------------------------------------------"

			HOST=`hostname`
        			echo "Hostname is: $HOST"

			IP=`hostname -I`
        			echo "IP is: $IP"

			DNS=`cat /etc/resolv.conf | tail -n 3`
        			echo "DNS settings: $DNS"
	echo "----------------------------------------------------------------"

			ROUTE=`route -n`
        			echo "$ROUTE"
	echo "----------------------------------------------------------------"

	}
	netstatus
	read -n 1 -p "press <Enter> for main menu"
	mainmenu
	;;

	4)
		function ports () {

	echo "----------------------------------------------------------------"
	echo "			PORTS|IPTABLES"
	echo "----------------------------------------------------------------"

			#Check open ports
			PORTS=`netstat -tuln`
        			echo "$PORTS"
	echo "----------------------------------------------------------------"

			#Check iptables
			IP4FW=`iptables -L -n`
        			echo "$IP4FW"
	echo "----------------------------------------------------------------"

	}
	ports
	read -n 1 -p "press <Enter> for main menu"
	mainmenu
	;;

	5)
		function ramusage () {

	echo "----------------------------------------------------------------"
	echo "			RAM USAGE"
	echo "----------------------------------------------------------------"

			RAM_USAGE=`free -m | xargs | awk '{print "FREE/TOTAL memory: " $17 " / " $8 " MB"}'`
				echo "$RAM_USAGE"

	echo "----------------------------------------------------------------"

	}
	ramusage
	read -n 1 -p "<Enter> for main menu"
	mainmenu
	;;

	6)
		function freespace () {

	echo "-----------------------------------------------------------------"
	echo "			SCAN SPACE MOUNTED ON /"
	echo "-----------------------------------------------------------------"
			DISK_USAGE=`df -h / | xargs | awk '{print "FREE/TOTAL: " $11 " / " $9}'`
				echo "$DISK_USAGE"

	echo "-----------------------------------------------------------------"
	echo "			/HOME"
	echo "-----------------------------------------------------------------"
			du -sh --time /home/*

	echo "-----------------------------------------------------------------"
	echo "			/VAR"
	echo "-----------------------------------------------------------------"
			du -sh --time /var/*

	echo "-----------------------------------------------------------------"
	echo "			/VAR/LOG"
	echo "-----------------------------------------------------------------"
			du -sh --time /var/log/*

	echo "-----------------------------------------------------------------"

	}
	freespace
	read -n 1 -p "<Enter> for main menu"
	mainmenu
	;;

	7)
		function software () {
	TIME=2

	echo "------------------------------------------------------------------"
	echo "		Listing first 50 high weight programs"
	echo "------------------------------------------------------------------"

	sleep $TIME

	dpkg-query --show --showformat='${Installed-Size}\t${Package}\n' | sort -rh | head -50 | awk '{print $1/1024, $2}' # > /tmp/programs.txt

	echo "------------------------------------------------------------------"
	# echo Programs listed and available at /tmp/programs.txt
	# echo "------------------------------------------------------------------"

	}
	software
	read -n 1 -p "press <Enter> for main menu"
	mainmenu
	;;

	8)

		function installed () {

	LIST_SOFT="curl git wget dkms apt-transport-https openssh-server openssh-client build-essential bash-completion swapspace"
	LIST_UTILS="htop lnav tmux ncdu mc"
	TIME=3

	# Use aptittude for programs loop
	apt install aptitude -y

	echo "-----------------------------------------------------------------"
	echo "	Update and Upgrade packages"
	echo "-----------------------------------------------------------------"

	sleep $TIME

	# Update and upgrade packages
		if apt update && apt upgrade -y
			then apt autoremove -y && apt autoclean
		fi

	echo "-----------------------------------------------------------------"
	echo "	Installing soft"
	echo "-----------------------------------------------------------------"

	sleep $TIME

	# Use aptitude for programs loop
	  apt install aptitude $LIST_SOFT $LIST_UTILS

	echo "-----------------------------------------------------------------"
	echo "	Update and install soft complete"
	echo "-----------------------------------------------------------------"

	}
	installed
	read -n 1 -p "press <Enter> for main menu"
	mainmenu
	;;

	0)
		echo Exiting the system..
		sleep $TIME
	       	exit 0
	       	;;
	esac
}
mainmenu
