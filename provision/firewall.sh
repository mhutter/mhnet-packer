#!/bin/bash
set -e -u -o pipefail -x

# Set default policy
ufw default allow outgoing
ufw default deny outgoing

# allow SSH access from internal systems
ufw allow proto tcp from 10.0.0.0/24 to any port 22

# Lastly, enable firewall
ufw enable
