# Install EPEL repository and update the system
yum install epel-release -y && yum update -y

# Install Fail2ban with firewalld and systemd support
yum install fail2ban-firewalld fail2ban-systemd -y 

# Install Git and Python3
yum -y install git python3

# Backup the original configuration file
mkdir -p /etc/bak/fail2ban_conf/ && cp -p /etc/fail2ban/jail.conf /etc/bak/fail2ban_conf/

# Get the current IP address
# get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')
get_my_ip=$(who|awk '{print $5}'| cut -d '(' -f2 | cut -d ')' -f1|sed -n '1p')

# Explanation of key parameters:
# "ssh-iptables" is the module configuration name. Usage: fail2ban-client status + module name
# Example: fail2ban-client status ssh-iptables

# ignoreip = 127.0.0.1 specifies which addresses (IP/domain) are exempt from Fail2ban protection, separated by spaces
# maxretry = 3 specifies the number of failed attempts before banning, used in conjunction with findtime
# findtime = 10 specifies the time window (in seconds) during which maxretry failures will result in a ban
# bantime = -1 specifies the ban duration in seconds; -1 means permanent ban
# action = specifies the action to take when an IP is banned
# logpath = /var/log/secure is the system log file where actions are recorded (varies by distribution)

echo -e "Installing and configuring Fail2ban: Except for your IP ($get_my_ip), all other IPs will be permanently banned after 3 failed password attempts.\n"
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

echo -e "Adding Fail2ban to the system service and enabling auto-start. Fail2ban is now running.\n"
systemctl enable fail2ban.service && systemctl start fail2ban.service
echo -e "To view banned IPs, use: fail2ban-client status ssh-iptables"
echo -e "To unban an IP, use: fail2ban-client set ssh-iptables unbanip xxx.xxx.xxx.xxx"

rm -rf $0

# Troubleshooting references:
# [stackoverflow-cant-enable-fail2ban-jail-sshd](https://stackoverflow.com/questions/42320994/cant-enable-fail2ban-jail-sshd)
# [How to Install Fail2ban on Rocky Linux and AlmaLinux](https://www.tecmint.com/install-fail2ban-rocky-linux-almalinux/)
