# Script to create a custom user with administrator privileges on a Linux system
# This script is designed to make the process as smooth as setting up a user on a Windows PC.

echo -e "After setting up the root user, use this script to create a custom user with administrator privileges.\n"
echo -e "⭐︎ A personalized account with admin rights, as smooth as using a Windows PC! ⭐︎\n"

#****************** Create a User in the Wheel Group *****************

# Prompt the user to enter a username and create a user in the 'wheel' group (admin group in CentOS/RHEL)
read -p "Enter the username: " user_name
useradd -g wheel $user_name

echo -e "\nUser '$user_name' has been created successfully.\n"

# Prompt the user to enter a password (displayed in plain text for verification)
echo -e "◉ Note: The password will be displayed in plain text for verification purposes.\n"
read -p "Enter the password: " pass_word

# Set the password for the new user
echo $pass_word | passwd --stdin $user_name

#************** Enable Wheel Group Privileges **************

# Allow the 'wheel' group to use 'sudo' without a password
# Step 1: Grant write permissions to the sudoers file
chmod u+w /etc/sudoers

# Step 2: Uncomment the line that allows the 'wheel' group to use sudo
sed -i 's/# %wheel/%wheel/g' /etc/sudoers

# Step 3: Add a rule to allow the new user to use 'sudo' without a password
echo "$user_name ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Step 4: Remove write permissions from the sudoers file for security
chmod u-w /etc/sudoers

# Step 5: Enable passwordless 'su' (switch user) for members of the 'wheel' group
sed -i 's/#a/a/g' /etc/pam.d/su

#********************** Additional Security Configurations *******************

# Copy the SSH authorized_keys file to the new user's home directory (if it exists)
# This allows the new user to use the same SSH keys as the root user
mkdir -p /home/$user_name/.ssh
cp -p ~/.ssh/authorized_keys /home/$user_name/.ssh/authorized_keys > /dev/null 2>&1

# Disable root login via SSH for better security
# Step 1: Remove any existing 'PermitRootLogin' line from the SSH config
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config

# Step 2: Add 'PermitRootLogin no' to disable root login
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# Reload the SSH service to apply the changes
systemctl reload sshd.service

# Notify the user that the configuration is complete
echo -e "\nRoot SSH login has been disabled (PermitRootLogin no). All configurations are complete."
echo -e "You can now log in using the new user '$user_name' via SSH.\n"

# Local debugging command (for testing purposes)
# scp ~/Desktop/diy_add_wheel.sh root@10x.xxx.xxx.xx5:$HOMEPATH

# Self-delete the script after execution
rm -rf $0
