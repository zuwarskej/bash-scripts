#!/bin/bash

# Description: stop iptables rules

echo "Cleaning iptables"
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

echo "Check iptables rules"
iptables -L -v -n
