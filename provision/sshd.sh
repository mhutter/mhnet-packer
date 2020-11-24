#!/bin/bash
set -e -u -o pipefail -x

# Remove small DH moduli
awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.safe
mv /etc/ssh/moduli.safe /etc/ssh/moduli

chmod 0600 /etc/ssh/sshd_config

cat > /etc/ssh/sshd_config <<EOT
AcceptEnv LANG LC_*
AddressFamily inet
AllowAgentForwarding no
AllowGroups sshlogin
AllowTCPForwarding no
AuthenticationMethods publickey
Banner none
ChallengeResponseAuthentication no
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
ClientAliveCountMax 3
ClientAliveInterval 300
DebianBanner no
GSSAPIAuthentication no
GSSAPICleanupCredentials yes
GatewayPorts no
HostKey /etc/ssh/ssh_host_ed25519_key
HostKey /etc/ssh/ssh_host_rsa_key
HostKeyAlgorithms ssh-rsa,rsa-sha2-512,rsa-sha2-256,ssh-ed25519
HostbasedAuthentication no
IgnoreRhosts yes
IgnoreUserKnownHosts yes
KerberosAuthentication no
KerberosOrLocalPasswd no
KerberosTicketCleanup yes
KexAlgorithms sntrup4591761x25519-sha512@tinyssh.org,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
LogLevel VERBOSE
LoginGraceTime 10
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
MaxAuthTries 2
MaxSessions 10
MaxStartups 2:30:10
PasswordAuthentication no
PermitEmptyPasswords no
PermitRootLogin no
PermitTunnel no
PermitUserEnvironment no
Port 22
PrintLastLog no
PrintMotd no
Protocol 2
PubkeyAuthentication yes
StrictModes yes
Subsystem sftp /usr/lib/openssh/sftp-server
SyslogFacility AUTH
TCPKeepAlive no
UseDNS no
UsePAM yes
X11Forwarding no
X11UseLocalhost yes
EOT
