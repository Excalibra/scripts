import sys
import socket
import getpass
import os
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont
import hostname_user_ip_date

'''
Author: Excalibra
Homepage: https://github.com/Excalibra
'''

# Set the Qt platform plugin path
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# Get the computer name and username
hostname, username = hostname_user_ip_date.get_hostname_username()

# Get the IP address
compute_addr = hostname_user_ip_date.get_preferred_ip()

# Get the date
current_date = hostname_user_ip_date.get_current_date()

# show = f'Screen Watermark-{hostname}-{username}-{current_date}-{compute_addr}'
show = f'Screen Watermark-{hostname}-{username}-{compute_addr}'

# Custom window class for displaying watermark
class WatermarkWindow(QWidget):
    def __init__(self, position, pady=100, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # Set opacity to 40%

        # Get screen width and height
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # Set window to fullscreen

        # Create watermark label
        self.label = QLabel(self)
        self.label.setText(show)
        self.label.setFont(QFont('Arial', 23))
        self.label.setStyleSheet('color: #708090;')

        # Use layout to set label position
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)  # Remove layout margins

        # Set watermark position
        if position == 'nw':  # Top left corner
            layout.setAlignment(Qt.AlignTop | Qt.AlignLeft)  # Align watermark to top-left
            layout.setContentsMargins(padx, pady, 0, 0)  # Adjust top-left margin
        elif position == 'sw':  # Bottom left corner
            layout.setAlignment(Qt.AlignBottom | Qt.AlignLeft)  # Align watermark to bottom-left
            layout.setContentsMargins(padx, 0, 0, pady)  # Adjust bottom-left margin
        elif position == 'ne':  # Top right corner
            layout.setAlignment(Qt.AlignTop | Qt.AlignRight)  # Align watermark to top-right
            layout.setContentsMargins(0, pady, padx, 0)  # Adjust top-right margin
        elif position == 'se':  # Bottom right corner
            layout.setAlignment(Qt.AlignBottom | Qt.AlignRight)  # Align watermark to bottom-right
            layout.setContentsMargins(0, 0, padx, pady)  # Adjust bottom-right margin
        elif position == 'center':  # Center of the screen
            layout.setAlignment(Qt.AlignCenter)  # Center-align watermark
        elif position == 'e':  # Middle right
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignRight)  # Vertically center, align right
        elif position == 'w':  # Middle left
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignLeft
