# hostname_user_ip.py
import sys
import getpass
import os
import socket
import psutil
from datetime import datetime

def get_current_date():
    """
    Return the current date in the format Year-Month-Day
    :return: str The current date
    """
    return datetime.now().strftime("%Y-%m-%d")  # Format: Year-Month-Day


def get_hostname_username():
    # Get the computer name
    hostname = socket.gethostname()
    # Get the logged-in username
    username = getpass.getuser()
    return hostname, username

def get_wifi_ip():
    # Get all network interfaces
    interfaces = psutil.net_if_addrs()

    # Iterate through all interfaces
    for interface, addrs in interfaces.items():
        if "WLAN" in interface:  # Find the Wi-Fi interface
            for addr in addrs:
                if addr.family == socket.AF_INET:  # Only get the IPv4 address
                    return addr.address
    
    return "127.0.0.1"  # If no Wi-Fi interface is found, return the loopback address

def get_ethernet_ip():
    # Get all network interfaces
    interfaces = psutil.net_if_addrs()

    # Iterate through all interfaces
    for interface, addrs in interfaces.items():
        if "以太网" in interface:  # Find the Ethernet interface
            for addr in addrs:
                if addr.family == socket.AF_INET:  # Only get the IPv4 address
                    return addr.address
    
    return "127.0.0.1"  # If no Ethernet interface is found, return the loopback address

def get_preferred_ip():
    """Prefer to return the Wi-Fi address; if no Wi-Fi is connected, return the Ethernet address."""
    wifi_ip = get_wifi_ip()
    if wifi_ip:
        return wifi_ip  # If the Wi-Fi address is found, return it
    else:
        return get_ethernet_ip()  # If no Wi-Fi is found, return the Ethernet address
