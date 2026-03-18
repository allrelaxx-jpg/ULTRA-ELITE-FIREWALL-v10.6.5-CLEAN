#!/usr/bin/env bash

systemctl stop nftables
systemctl disable nftables

rm -f /etc/nftables.conf

echo "Firewall removed"
