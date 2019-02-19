#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#Check Root
[ $(id -u) != "0" ] && { echo "此脚本得需要root环境!"; exit 1; }
echo -e "此加速bbr需要64位系统，你的系统是否合适"
echo -e "1.是\n2.否"
read -p "输入数字以选择:" hex
while [[ ! "${hex}" =~ ^[1-2]$ ]]
do
	echo -e "${Error} 无效输入"
	echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" hex
done
#Check OS
if [ -n "$(grep 'Aliyun Linux release' /etc/issue)" -o -e /etc/redhat-release ];then
    OS=CentOS
    [ -n "$(grep ' 7\.' /etc/redhat-release)" ] && CentOS_RHEL_version=7
    [ -n "$(grep ' 6\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release6 15' /etc/issue)" ] && CentOS_RHEL_version=6
    [ -n "$(grep ' 5\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release5' /etc/issue)" ] && CentOS_RHEL_version=5
elif [ -n "$(grep 'Amazon Linux AMI release' /etc/issue)" -o -e /etc/system-release ];then
    OS=CentOS
    CentOS_RHEL_version=6
elif [ -n "$(grep bian /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Debian' ];then
    OS=Debian
    [ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
    Debian_version=$(lsb_release -sr | awk -F. '{print $1}')
elif [ -n "$(grep Deepin /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Deepin' ];then
    OS=Debian
    [ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
    Debian_version=$(lsb_release -sr | awk -F. '{print $1}')
elif [ -n "$(grep Ubuntu /etc/issue)" -o "$(lsb_release -is 2>/dev/null)" == 'Ubuntu' -o -n "$(grep 'Linux Mint' /etc/issue)" ];then
    OS=Ubuntu
    [ ! -e "$(which lsb_release)" ] && { apt-get -y update; apt-get -y install lsb-release; clear; }
    Ubuntu_version=$(lsb_release -sr | awk -F. '{print $1}')
    [ -n "$(grep 'Linux Mint 18' /etc/issue)" ] && Ubuntu_version=16
else
    echo "不支持此操作系统，请联系作者！"
    kill -9 $$
fi


if [[ ${os} == Debian ]];then
	apt-get update
	apt-get install git unzip wget -y
	if [ virt-what == kvm ];then
		echo -e "此加速bbr需要Debian 7+，你的系统是否合适"
		echo -e "1.是\n2.否"
		read -p "输入数字以选择:" hec
		while [[ ! "${hec}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} 无效输入"
			echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" hec
		done
		if [ ${hec} == 1 ];then
			wget https://github.com/tcp-nanqinlang/general/releases/download/3.4.2.1/tcp_nanqinlang-fool-1.3.0.sh
			bash tcp_nanqinlang-fool-1.3.0.sh
		fi
	fi
	if [ virt-what == openvz ];then
		echo -e "此加速bbr需要Debian 8+，你的系统是否合适"
		echo -e "1.是\n2.否"
		read -p "输入数字以选择:" hec
		while [[ ! "${hec}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} 无效输入"
			echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" hec
		done
		if [ ${hec} == 1 ];then
			wget https://github.com/tcp-nanqinlang/lkl-haproxy/releases/download/1.1.1/tcp_nanqinlang-haproxy-debian.sh
			bash tcp_nanqinlang-haproxy-debian.sh
		fi
	fi
fi
if [[ ${OS} == CentOS ]];then
	yum install git unzip wget-y
	if [ virt-what == kvm ];then
		echo -e "此加速bbr需要CentOS 6/7，你的系统是否合适"
		echo -e "1.是\n2.否"
		read -p "输入数字以选择:" hec
		while [[ ! "${hec}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} 无效输入"
			echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" hec
		done
		if [ ${hec} == 1 ];then
			wget https://raw.githubusercontent.com/tcp-nanqinlang/general/master/General/CentOS/bash/tcp_nanqinlang-1.3.2.sh
			bash tcp_nanqinlang-1.3.2.sh
		fi
	fi
	if [ virt-what == openvz ];then
		echo -e "此加速bbr需要CentOS 7，你的系统是否合适"
		echo -e "1.是\n2.否"
		read -p "输入数字以选择:" hec
		while [[ ! "${hec}" =~ ^[1-2]$ ]]
		do
			echo -e "${Error} 无效输入"
			echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" hec
		done
		if [ ${hec} == 1 ];then
			wget https://github.com/tcp-nanqinlang/lkl-haproxy/releases/download/1.1.1/tcp_nanqinlang-haproxy-centos.sh
			bash tcp_nanqinlang-haproxy-centos.sh
		fi
	fi
fi
if [[ ${os} == Ubuntu ]];then
	echo "不支持此操作系统!"
fi
