#!/bin/bash
set -e

## setup hosts
IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME |grep -Po 'inet \K[\d.]+')"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

## setup DNS
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf
service systemd-resolved restart

## setup tools provided as per
## https://docs.linuxfoundation.org/tc-docs/certification/important-instructions-cks
apt-get update -y && \
apt-get install chrony \
jq tmux curl wget man -y