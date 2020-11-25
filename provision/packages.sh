#!/bin/bash
set -e -u -o pipefail -x

packages_to_install=(
  apt-transport-https
  auditd
  ca-certificates
  curl
  rsyslog
  software-properties-common
  ufw
)
packages_to_remove=(
  apport
  aptitude
  btrfs-progs
  cryptsetup
  firewalld
  linux-firmware
  man-db
  snapd
  unattended-upgrades
)

# wait for apt lock
while fuser -s /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock; do
  sleep 2
done

apt-get update -qq
apt-get purge -yq --autoremove "${packages_to_remove[@]}"
apt-get dist-upgrade -yq
apt-get install -yq "${packages_to_install[@]}"
