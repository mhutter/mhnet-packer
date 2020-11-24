#!/bin/bash
set -e -u -o pipefail -x

# Remove small DH moduli
awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.safe
mv /etc/ssh/moduli.safe /etc/ssh/moduli

chmod 0600 /etc/ssh/sshd_config
