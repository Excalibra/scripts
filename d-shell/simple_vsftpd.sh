## For future use, this tool can be used for configuring web cloud disk sharing: https://github.com/zfile-dev/zfile
#*******************************************************************

#********* Cloud Setting Reminder ***************************
#
# FTP can connect and transfer data with client machines in both active and passive modes.
# Due to firewall settings on most client machines and the inability to obtain real IP addresses, it is recommended to choose passive mode for setting up the FTP service.
# The following modifications are for setting up passive mode. If you need to choose active mode, please go to Set Up FTP Active Mode.
#
# The difference between active and passive modes can be simply summarised as:
# In active mode, data transfer is from the "server" connecting to the "client's" port (client opens the data port).
# In passive mode, data transfer is from the "client" connecting to the "server's" port (server opens the data port).
#****************************************************


#----------- Download and Install, Dedicated User Creation and Directory Limitation ------------

# Add a user; ordinary users do not have permission to log in via SSH, additional authorisation is required, but it's fine.
# For completeness, usermod -s /sbin/nologin ftpuser has been done.

yum install -y vsftpd
yum install lsof -y
sudo systemctl enable vsftpd
# Successfully started. Anonymous access is enabled by default, but without permissions to modify or upload.
sudo systemctl start vsftpd
# Create a new group and add the user to the ftpusers group.
sudo groupadd ftpusers && sudo useradd -g ftpusers ftpuser
# Restrict login terminal
sudo usermod -s /sbin/nologin ftpuser 
echo "P@ssw0rd"|sudo passwd --stdin ftpuser # Password rules tested and passed
# Create a specific directory for FTP sharing
sudo sudo mkdir /var/ftp/share
echo "hello world " > /var/ftp/share/test.txt
# Authorisation -R recursive; owner:group 
sudo chown -R ftpuser:ftpusers /var/ftp/share

#---------- Backup vsftpd.conf File and Obtain Public IP -----------

# Here configuration modifications are for passive mode.
# Backup the source directory file vsftpd.conf.bak
cp -rp /etc/vsftpd/vsftpd.conf{,.bak}

# Obtain the Linux server's public IP
linux_public_ip=$(curl -s https://api.ipify.org/ |grep 'class="fz24"' | awk -F '>|<' '{print$3}')

# Obtain the IP of a Windows or Mac computer (client)
get_my_ip=$(who|awk '{print $5}'| cut -d '(' -f2 | cut -d ')' -f1|sed -n '1p')

# This method of obtaining IP might be risky due to potential SSH interference, hence commented out
# get_my_ip=$(netstat -n|grep -i :22|awk '{print $5}'|cut -d":" -f1|sed -n '1p')

# cut
# -d indicates the need to use a custom delimiter
# -f2 indicates selecting the second part of the split content for output
# -f1 indicates selecting the first part of the split content for output

#------------------------------------------------------


#************************ Explanatory Documentation ***************************************
#
# local_enable=YES         # Support local user login
# chroot_local_user=YES    # All users are restricted to their home directory
# chroot_list_enable=YES   # Enable exception user list
# chroot_list_file=/etc/vsftpd/chroot_list  # Specify the user list file, users in this list are not locked in their home directory
#
#*********************************************************************


#----------- vsftpd.conf Configure Basic User Policies: Disable Anonymous, Restrict Access to Specified Directory, IPv4 ----------

# Replace line 12 globally with anonymous_enable=NO
sed -i '12canonymous_enable=NO' /etc/vsftpd/vsftpd.conf


## Uncomment lines 100, 101, 103, configure chroot as above.
sed -i '100,101s/^#//' /etc/vsftpd/vsftpd.conf
sed -i '103s/^#//' /etc/vsftpd/vsftpd.conf

# Replace Listen=NO with Listen=YES
sed -i 's/listen=NO/listen=YES/' /etc/vsftpd/vsftpd.conf

# Add a comment at the beginning of line 123, i.e., disable IPv6 sockets
sed -i '123s/^/# /' /etc/vsftpd/vsftpd.conf

# Uncomment line 52 to enable logging
sed -i '52s/^#//' /etc/vsftpd/vsftpd.conf

# Enable passive mode pasv_enable=YES
# Minimum and maximum connection ports for pasv mode
# Setting the minimum and maximum port numbers to the same value opens a fixed port
# allow_writeable_chroot=YES allows writing in the restricted directory
echo -e "
local_root=/var/ftp/share
allow_writeable_chroot=YES
pasv_enable=YES
pasv_address=$linux_public_ip
pasv_min_port=21000
pasv_max_port=21000
" >> /etc/vsftpd/vsftpd.conf

# Create a file, otherwise even with a user, login will fail. No other permissions are needed, ftpuser does not access this file.
# It is speculated that the program logic relies on this "small file" to make policy decisions. The configuration enables this feature, but without the file, it naturally goes haywire. (The coder probably didn't think much about it, maybe didn't want to deal with it...)
touch /etc/vsftpd/chroot_list
## chroot_list_file=/etc/vsftpd/chroot_list Open the restricted list file configuration


# Comment out line 4 auth required pam_shells.so module authentication.
sudo sed -i '4s/^/#/' /etc/pam.d/vsftpd

#------ pam_access.so is a module that calls the configuration file /etc/security/access.conf ------

# /etc/pam.d/vsftpd (Module configuration file)
## Backup /etc/pam.d/vsftpd
cp -rp /etc/pam.d/vsftpd{,.bak}
# Insert module before line 7
sudo sed -i '7i\account    required     pam_access.so' /etc/pam.d/vsftpd

# access.conf
## Backup access.conf file
cp -rp /etc/security/access.conf{,.bak}
## Define the last rule as deny all, meaning only the allowed exceptions
## Online configurations might be outdated, so no need to add '@' for access, intelligently recognises group names, etc.
echo  -e "
+:ftpusers:$get_my_ip
-:ALL:ALL

" >> /etc/security/access.conf

#---------------------------------------------------


# Restart the FTP service.
sudo systemctl restart vsftpd

echo -e "***Debugging Code***"
echo 'scp /Users/user1/Desktop/1.sh root@101.xxx.xxx.xxx:${HOMEPATH}'
echo -e "rm -rf ~/.ssh/known_hosts && rm -rf ~/.ssh/known_hosts.old"
echo -e "View all user information: cat /etc/passwd"
echo -e "Create a new user, add to FTP shared group: useradd -G ftpusers <username>"
echo -e "Existing user, add to FTP shared group: usermod -a -G ftpusers <username>"
echo -e "***************** \n"

echo -e "\n ****************FTP Basic Explanation and Overview******************** \n"
echo -e "FTP dedicated user created: ftpuser; Password: P@ssw0rd"
echo -e "FTP shared directory location: cat /var/ftp/share"
echo -e "Important: Ensure that port 21000 is open in your cloud server's firewall settings."

echo -e "\nAt this point, FTP setup is complete. Below is a brief overview of FTP-related configurations."
echo -e "View FTP access history: /var/log/xferlog"
echo -e "Core configuration file: vi /etc/vsftpd/vsftpd.conf"
echo -e "FTP user and IP access restriction file: vi /etc/security/access.conf\n"
echo -e "Windows can use File Explorer to access, allowing upload and download."
echo -e "Mac recommends using Cyberduck, FileZilla, or ForkLift for access, as the native Finder has limited FTP support.\n"


# Delete itself
rm -rf $0

# This explanation might be distracting for first-time users
# echo -e "User access to other directories restriction configuration file: /etc/vsftpd/chroot_list"
# echo -e "Specific method: Fill in the usernames that you want to allow unrestricted access, one username per line.\n"


#****************Interlude***********************************

# cp -p /etc/ssh/{ssh_config,sshd_config,sshd_config.bak} Not feasible
## Linux View User's Group groups ftpuser Create Group: groupadd ftpusers 
## Create a new user and add to a specified user group as their primary user group (each user has one and only one primary user group)
## Create a new user and associate with a group
## useradd -g <groupname> <username>
## Or create a new user and add to specified secondary user groups, secondary groups can be multiple, separated by commas
## useradd -G <groupname> <username>
## Existing user
## -a stands for append, used with -G to add the user to a new user group without leaving existing groups
## usermod -a -G <groupname> <username>

## Google Cloud, selinux is enabled by default. Domestic machines, internal firewalls are disabled by default.
## If you have enabled the firewall internally on your server, you need to set policies on both sides.
## Some cloud firewall settings defaults to open ports unless additional restrictions are applied, based on current policies.

# By default, it should not protect already open ports, whether ports are open fundamentally depends on the services or applications you run,
# These will open ports that were not open before, the firewall only protects these ports when enabled, it is not the firewall that opens these ports.
# For example, port 80, only when you run a web application, such as IIS, will port 80 be opened on the server, at this time the firewall may protect port 80,
# Preventing external users from accessing, but when the firewall is disabled, the protection is cancelled and normal access is allowed, so the firewall is not the root cause of opening port 80
