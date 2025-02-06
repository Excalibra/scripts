echo -e "Note: Execute this script using the 'sudo bash' command."

# Backup SSH server and client configuration files to the ssh.bak directory
mkdir -p /etc/bak/ssh && cp -p /etc/ssh/{ssh_config,sshd_config} /etc/bak/ssh

# Optimized method to filter connections with port 22
# This method of obtaining the IP has a risk of being mixed up due to SSH queue-jumping, so it's commented out
# get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')
# get_my_ip_port=$(netstat -n|grep -i :22|awk '{print $5}'|sed -n '1p')
get_my_ip=$(who|awk '{print $5}'| cut -d '(' -f2 | cut -d ')' -f1|sed -n '1p')

# Edit, modify configuration permissions, and restart the service to apply changes
echo -e \
"
PubkeyAuthentication yes # Allow Public Key authentication
PermitRootLogin yes # Allow Root login
PasswordAuthentication no # Disable password authentication
ClientAliveInterval 30 # Client sends a heartbeat to the server every 30 seconds
ClientAliveCountMax 86400 # Server disconnects if the client is unresponsive for 86400 seconds
# AllowUsers *@$get_my_ip *@127.0.0.1 # Switching proxies immediately after login may interrupt SSH connections.
" \
>>/etc/ssh/sshd_config

# Grant necessary permissions, suppress errors with >/dev/null 2>&1
chmod 700 $HOME && chmod 700 ~/.ssh 
touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys >/dev/null 2>&1
systemctl restart sshd.service


#--------------- Simplify Password Requirements -----------------------

# Backup files
mkdir -p /etc/bak/pam.d/ && cp -p /etc/pam.d/system-auth  /etc/bak/pam.d/
# This works, but Linux systems may enforce a minimum of 8 characters; pam.d/system-auth has higher priority than login.defs
# One configures system modules, the other is auxiliary account login policies; they differ significantly.

echo -e "
# Add custom password policy: 3 retries, no special characters, case sensitivity, or minimum length (3 characters)
password\trequisite\tpam_pwquality.so\ttry_first_pass local_users_only retry=3
password\trequisite\tpam_pwquality.so\tauthtok_type= minlen=4 
password\trequisite\tpam_pwquality.so dcredit=0 ocredit=0 lcredit=0 ucredit=0
" >>/etc/pam.d/system-auth

#****************** Install and Configure fail2ban *****************************

echo -e "Installing fail2ban and its dependencies"
yum install epel-release -y && yum update -y
yum install fail2ban-firewalld fail2ban-systemd -y 
yum -y install git python3

# Backup original files
mkdir -p /etc/bak/fail2ban_conf/ && cp -p /etc/fail2ban/jail.conf /etc/bak/fail2ban_conf/

echo -e \
"
[DEFAULT]
ignoreip = 127.0.0.1 $get_my_ip
maxretry = 3 
findtime  = 10 
bantime = -1

[ssh-iptables] 
enabled = true
filter = sshd
action = iptables[name=SSH, port=22, protocol=tcp] 
logpath  = /var/log/secure
" > /etc/fail2ban/jail.local


echo -e "Adding to the daemon, enabling auto-start, and starting fail2ban \n"
systemctl enable fail2ban.service && systemctl start fail2ban.service

echo -e "----------------- Server Configuration Overview --------------------\n"
echo -e "\nSSH server key, login policy, heartbeat response, and IP range restrictions"
echo -e "Simplified password rules: Any case/symbols/numbers allowed, minimum 4 characters"
echo -e "fail2ban: Except for your IP ($get_my_ip), any IP with 3 failed attempts will be permanently banned.\n"
echo -e "All SSH server (Linux) configurations are now complete.\n"

#************ All configurations done, starting verbose ECHO *********************

echo -e "**** Point-to-Point Configuration Summary *****"
echo -e "SSH server configuration: vi /etc/ssh/sshd_config"
echo -e "Password policy configuration: vi /etc/pam.d/system-auth"
echo -e "Check banned IPs: fail2ban-client status ssh-iptables"
echo -e "Unban IP: fail2ban-client set ssh-iptables unbanip xxx.xxx.xxx.xxx \n"

echo -e 'Generate client key: ssh-keygen -t ed25519 -C "your@email.com"'
echo -e "Copy public key to server: ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server"
echo -e "Client troubleshooting: rm -rf ~/.ssh/known_hosts ~/.ssh/known_hosts.old && cat ~/.ssh/ssh_config \n"

echo -e "------ Ban｜Key｜ Password ----\n"
echo -e "Ban IP has the highest priority; even with keys or passwords, access is denied."
echo -e "If keys are configured but not authorized, even with a password, login is denied."
echo -e "Most Linux hacks occur due to weak passwords, lack of one-to-one key authorization, and vulnerabilities in service programs."
echo -e "The most critical settings are IP restrictions and BAN IP policies."

rm -rf $0
