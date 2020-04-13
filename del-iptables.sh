#!/bin/sh

# ------------------------------------------------
# Description: script for stopping iptables rules
# Written by : zuwarskej
# ------------------------------------------------

echo "Stopping firewall"
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
