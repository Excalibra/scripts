echo -e "Note: To execute this script, use the command 'sudo bash'. It configures the SSH server for login, password authentication, long session heartbeat connections, and restricts IP ranges to home use only.\n"

echo -e "---------- Configuring Server: Linux SSH, Starting ---------------\n"

# Backup SSH server and client configuration files to the ssh.bak directory
mkdir -p /etc/bak/ssh && cp -p /etc/ssh/{ssh_config,sshd_config} /etc/bak/ssh

# Use netstat -t to check connections, awk to extract the 5th column, and filter out ports containing letters to get the correct IP pool.
# Then, cut the port from the IP pool, take the second row of data, and get the IP connected to the server.
# get_my_ip=$(netstat -t|awk '{print $5}'|grep -v -E '[a-zA-Z]'|cut -d":" -f1|sed -n '1p')
# get_my_ip=$(netstat -t|awk '{print $5}'|grep -v -E '[a-zA-Z]|^10|^169|^172|^192'|cut -d":" -f1|sed -n '1p')

# Optimized filtering method: select those with :22.
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
ClientAliveCountMax 86400  # Server disconnects if the client doesn't respond within 86400 seconds
AllowUsers *@$get_my_ip *@127.0.0.1 # Restrict SSH connections to specific IPs
" \
>>/etc/ssh/sshd_config

# Grant necessary permissions, suppress errors with >/dev/null 2>&1, and restart the SSH service
chmod 700 $HOME && chmod 700 ~/.ssh 
touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys >/dev/null 2>&1
systemctl restart sshd.service

#--------------- Simplify Account Password Requirements -----------------------

# Backup files
mkdir -p /etc/bak/pam.d/ && cp -p /etc/pam.d/system-auth  /etc/bak/pam.d/
# This works, but Linux systems may still enforce a minimum of 8 characters; pam.d/system-auth has higher priority than login.defs
# One configures system modules, the other is just an auxiliary account login policy, with significant differences.

echo -e "
# Add custom password policy: allow 3 retries, no special characters or uppercase required, minimum length of 4
password\trequisite\tpam_pwquality.so\ttry_first_pass local_users_only retry=3
password\trequisite\tpam_pwquality.so\tauthtok_type= minlen=4 
password\trequisite\tpam_pwquality.so dcredit=0 ocredit=0 lcredit=0 ucredit=0
" >>/etc/pam.d/system-auth

echo -e "\nSSH server key, login policy, heartbeat response, and IP range restrictions configured."
echo -e "Simplified user password rules: any case/symbols/numbers allowed, minimum length of 4."
echo -e "All settings for the SSH server (Linux) have been completed.\n"
echo -e "About the server configurations modified this time:\n"
echo -e "SSH configurations: vi /etc/ssh/sshd_config"
echo -e "Password policy configurations: vi /etc/pam.d/system-auth \n"

echo -e "--- Start configuring Windows/Mac clients. Advanced tool: Remote SSH for VSCode. ---------\n"
echo -e 'Step 1: Generate SSH key on Windows/Mac: ssh-keygen -t ed25519 -C "your@email.com" \n'
echo -e "Step 2: Copy the public key to the remote server: ssh-copy-id -i ~/.ssh/id_ed25519.pub user@server \n"
echo -e "Client configuration is now complete.\n"
echo -e "------ Other FAQs ------\n"
echo -e "If you encounter 'Host key verification failed', run the following command to resolve:\n"
echo -e "rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old\n"
echo -e "After successful passwordless login, you can comment out the AllowUsers IP whitelist in sshd_config, as only your host is authorized."
echo -e "You can also install fail2ban or modify this script to customize IP activity ranges. \n"

# Self-delete the script
rm -rf $0

# Additional notes and references are omitted for brevity.
