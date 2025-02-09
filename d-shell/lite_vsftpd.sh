## For future use, consider this tool for configuring web-based cloud storage sharing: [Zfile on GitHub](https://github.com/zfile-dev/zfile)

#********* Cloud Documentation Reminder ***************************
#
# FTP can connect and transfer data with client machines in both active and passive modes.
# Due to firewall settings on most client machines and the inability to obtain real IPs, it is recommended to set up the FTP service in passive mode.
# The following modifications are for setting up passive mode. If you prefer active mode, please refer to the guide for setting up FTP active mode.
#
# In simple terms, the difference between active and passive modes is:
# - **Active Mode**: The server connects to the client's port for data transfer (client opens the data port).
# - **Passive Mode**: The client connects to the server's port for data transfer (server opens the data port).
#****************************************************


#----------- Download, Install, Create Dedicated User, and Restrict Directory ------------

# Add a user. Regular users do not have SSH login permissions by default, which is fine.
# For completeness, use `usermod -s /sbin/nologin ftpuser`.

yum install -y vsftpd
yum install lsof -y
sudo systemctl enable vsftpd
# Start the service successfully. Anonymous access is enabled by default but without permission to modify or upload.
# Start it early to avoid errors during configuration.
sudo systemctl start vsftpd

sudo groupadd ftpusers
# Accept user input and create a user in the ftpusers group
read -p "Enter the username for FTP sharing: " user_name && sudo useradd -g ftpusers $user_name

echo -e "User $user_name has been created. \n"

echo "⚠️  Note: Linux initial password rules require passwords to include uppercase, lowercase, and special characters. ‼️"
echo -e "If you have configured password policies, you can ignore this message."
echo -e "◉ Note: The password will be displayed in plain text for verification. \n"

# -s: Hide input for sensitive information
read -p "Enter the password: " pass_word 

# Pass the password to `passwd` via stdin
echo $pass_word | passwd --stdin $user_name

# Restrict login terminal
sudo usermod -s /sbin/nologin $user_name

# Create a specific directory for FTP sharing
sudo sudo mkdir /var/ftp/share
echo "hello world " > /var/ftp/share/test.txt
# Grant permissions -R recursively; owner:group 
sudo chown -R ftpuser:ftpusers /var/ftp/share

#---------- Backup vsftpd.conf File and Obtain Public IP -----------

# Configuration modifications are for passive mode.
# Modify: Find and replace. Test with `sed` without parameters first, then add comments for clarity.
# Backup the original vsftpd.conf file
cp -rp /etc/vsftpd/vsftpd.conf{,.bak}

# Obtain the public IP of the Linux machine
linux_public_ip=$(curl -s https://ipinfo.io/ |grep 'class="fz24"' | awk -F '>|<' '{print$3}')

# This method of obtaining IP is risky due to potential SSH interference, so it's commented out
# get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')

# New method to obtain the client IP (Windows or Mac)
get_my_ip=$(who|awk '{print $5}'| cut -d '(' -f2 | cut -d ')' -f1|sed -n '1p')

# cut
# -d specifies a custom delimiter
# -f2 selects the second part of the split output
# -f1 selects the first part of the split output

#------------------------------------------------------


#************************ Explanatory Documentation ***************************************
#
# local_enable=YES         # Allow local users to log in
# chroot_local_user=YES    # Restrict all users to their home directory
# chroot_list_enable=YES   # Enable a list of exception users
# chroot_list_file=/etc/vsftpd/chroot_list  # Specify the user list file; users in this list are not restricted to their home directory
#
#*********************************************************************


#----------- Configure Basic User Policies: Disable Anonymous Access, Restrict Access to Specified Directory, IPv4 -----------

# Replace line 12 globally with `anonymous_enable=NO`
sed -i '12canonymous_enable=NO' /etc/vsftpd/vsftpd.conf

## Uncomment lines 100, 101, and 103 to configure chroot as above.
sed -i '100,101s/^#//' /etc/vsftpd/vsftpd.conf
sed -i '103s/^#//' /etc/vsftpd/vsftpd.conf

# Replace `Listen=NO` with `Listen=YES`
sed -i 's/listen=NO/listen=YES/' /etc/vsftpd/vsftpd.conf

# Comment out line 123 to disable IPv6 sockets
sed -i '123s/^/# /' /etc/vsftpd/vsftpd.conf

# Uncomment line 52 to enable logging
sed -i '52s/^#//' /etc/vsftpd/vsftpd.conf

# Enable passive mode: `pasv_enable=YES`
# Set the minimum and maximum ports for passive connections
# Configuring the minimum and maximum ports to the same value opens a fixed port
# `allow_writeable_chroot=YES` allows writing within the restricted directory
echo -e "
local_root=/var/ftp/share
allow_writeable_chroot=YES
pasv_enable=YES
pasv_address=$linux_public_ip
pasv_min_port=21000
pasv_max_port=21000
" >> /etc/vsftpd/vsftpd.conf

# Create a file; otherwise, users cannot log in even if they exist. No additional permissions are needed; ftpuser does not access this file.
# It is speculated that the program logic relies on this "small file" for policy decisions. If the feature is enabled but the file is missing, it causes issues.
touch /etc/vsftpd/chroot_list
## `chroot_list_file=/etc/vsftpd/chroot_list` enables the restricted user list file configuration.

# Comment out line 4: `auth required pam_shells.so` module authentication.
sudo sed -i '4s/^/#/' /etc/pam.d/vsftpd

#------ `pam_access.so` is a module that calls the configuration file `/etc/security/access.conf` ------

# `/etc/pam.d/vsftpd` (module configuration file)
## Backup `/etc/pam.d/vsftpd`
cp -rp /etc/pam.d/vsftpd{,.bak}
# Insert the module before line 7
sudo sed -i '7i\account    required     pam_access.so' /etc/pam.d/vsftpd

# `access.conf`
## Backup the `access.conf` file
cp -rp /etc/security/access.conf{,.bak}
## Define the last rule as "deny all," meaning only explicitly allowed exceptions are permitted
echo  -e "
+:ftpusers:$get_my_ip
-:ALL:ALL

" >> /etc/security/access.conf

#---------------------------------------------------

# Start the FTP service.
sudo systemctl restart vsftpd

echo -e "*** Debugging Code ***"
echo 'scp /Users/user1/Desktop/1.sh root@101.xxx.xxx.xxx:${HOMEPATH}'
echo -e "rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old"
echo -e "View all user information: cat /etc/passwd"
echo -e "Create a new user and add to the FTP sharing group: useradd -G ftpusers <username>"
echo -e "Add an existing user to the FTP sharing group: usermod -a -G ftpusers <username>"
echo -e "***************** \n"

echo -e "\n **************** FTP Overview and Basic Information ******************** \n"
echo -e "FTP dedicated user created: $user_name; Password: $pass_word"
echo -e "FTP shared directory location: cat /var/ftp/share"
echo -e "Important ‼️: Ensure port 21000 is open in your cloud security group or cloud server firewall."

echo -e "\nFTP setup is complete. Below is a brief overview of FTP configurations:"
echo -e "View FTP access history: /var/log/xferlog"
echo -e "Core configuration file: vi /etc/vsftpd/vsftpd.conf"
echo -e "FTP user and IP access control file: vi /etc/security/access.conf\n"
echo -e "Windows users can access via File Explorer for uploads and downloads."
echo -e "Mac users are recommended to use Cyberduck, FileZilla, or ForkLift, as Finder's FTP support is limited.\n"

# Delete itself
rm -rf $0

# This explanation might be distracting for beginners
# echo -e "User access restriction configuration file: /etc/vsftpd/chroot_list"
# echo -e "To allow unrestricted access, add the username to this file, one username per line.\n"

#**************** Interlude ***********************************

## Check user groups: `groups ftpuser`. Create a group: `groupadd ftpusers`.
## Create a new user and add to a specified group as the primary group (each user has only one primary group).
## Create a new user and associate with a group:
## `useradd -g <groupname> <username>`
## Or, create a new user and add to a supplementary group (a user can belong to multiple supplementary groups):
## `useradd -G <groupname> <username>`
## For existing users:
## `-a` stands for append, used with `-G` to add the user to a new group without leaving existing groups.
## `usermod -a -G <groupname> <username>`

## Google Cloud enables SELinux by default. Domestic servers typically disable internal firewalls.
## If you enable a firewall on your server, you need to configure policies on both ends.

# By default, it should not protect already open ports. Whether a port is open depends on the service or application running.
# These services or applications open ports that were previously closed. The firewall only protects these ports when enabled.
# For example, port 80 is only opened when a web application like IIS is running. The firewall may protect port 80,
# preventing external users from accessing it. When the firewall is disabled, the protection is removed, and access is allowed.
# Therefore, the firewall is not the root cause of opening port 80.
