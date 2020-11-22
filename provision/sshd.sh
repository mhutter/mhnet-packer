#!/bin/bash
set -e -u -o pipefail -x

# Remove small DH moduli
awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.safe
mv /etc/ssh/moduli.safe /etc/ssh/moduli

cat > /etc/ssh/sshd_config <<EOT
AcceptEnv LANG LC_*
AllowGroups sshlogin
AllowTCPForwarding yes
AuthenticationMethods publickey
ChallengeResponseAuthentication no
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
DebianBanner no
GatewayPorts no
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
HostKeyAlgorithms ssh-rsa,rsa-sha2-512,rsa-sha2-256,ssh-ed25519
HostbasedAuthentication no
IgnoreRhosts yes
KexAlgorithms sntrup4591761x25519-sha512@tinyssh.org,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
LogLevel VERBOSE
LoginGraceTime 10
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
MaxStartups 2:30:10
PasswordAuthentication no
PermitEmptyPasswords no
PermitRootLogin no
PrintLastLog yes
PrintMotd no
Protocol 2
StrictModes yes
Subsystem sftp /usr/lib/openssh/sftp-server
SyslogFacility AUTHPRIV
UseDNS no
UsePAM yes
UsePrivilegeSeparation yes
X11Forwarding no
EOT
