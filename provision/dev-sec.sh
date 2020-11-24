#!/bin/bash
set -e -u -o pipefail -x

cat > /etc/modprobe.d/dev-sec.conf <<EOT
install cramfs /bin/true
install freevxfs /bin/true
install jffs2 /bin/true
install hfs /bin/true
install hfsplus /bin/true
install squashfs /bin/true
install udf /bin/true
install vfat /bin/true
EOT

cat > /etc/login.defs <<EOT
CHFN_RESTRICT     rwh
DEFAULT_HOME      yes
ENCRYPT_METHOD    SHA512
ENV_PATH          PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
ENV_SUPATH        PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ERASECHAR         0177
FAILLOG_ENAB      yes
FTMP_FILE         /var/log/btmp
GID_MAX           60000
GID_MIN           1000
HUSHLOGIN_FILE    .hushlogin
KILLCHAR          025
LOG_OK_LOGINS     no
LOG_UNKFAIL_ENAB  no
LOGIN_RETRIES     5
LOGIN_TIMEOUT     60
MAIL_DIR          /var/mail
PASS_MAX_DAYS     60
PASS_MIN_DAYS     7
PASS_WARN_AGE     7
SU_NAME           su
SYSLOG_SG_ENAB    yes
SYSLOG_SU_ENAB    yes
TTYGROUP          tty
TTYPERM           0600
UID_MAX           60000
UID_MIN           1000
UMASK             027
USERGROUPS_ENAB   yes
EOT

cat > /etc/sysctl.d/99-dev-sec.conf <<EOT
kernel.sysrq = 0

net.ipv4.icmp_ratelimit = 100
net.ipv4.icmp_ratemask = 88089
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_rfc1337 = 1

net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.router_solicitations = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_defrtr = 0
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.default.dad_transmits = 0
net.ipv6.conf.default.max_addresses = 1
EOT

cat > /etc/audit/auditd.conf <<EOT
action_mail_acct = root
admin_space_left = 50
admin_space_left_action = SUSPEND
disk_error_action = SUSPEND
disk_full_action = SUSPEND
dispatcher = /sbin/audispd
disp_qos = lossy
distribute_network = no
enable_krb5 = no
flush = INCREMENTAL_ASYNC
freq = 50
krb5_principal = auditd
local_events = yes
log_file = /var/log/audit/audit.log
log_format = RAW
log_group = adm
max_log_file = 8
max_log_file_action = keep_logs
name_format = NONE
num_logs = 5
priority_boost = 4
space_left = 75
space_left_action = SYSLOG
tcp_client_max_idle = 0
tcp_listen_queue = 5
tcp_max_per_addr = 1
use_libwrap = yes
verify_email = yes
write_logs = yes
EOT
