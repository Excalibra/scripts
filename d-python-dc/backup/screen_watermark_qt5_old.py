# screen_watermark_qt5_old.py
import sys
import socket
import getpass
import os
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QVBoxLayout
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

'''
Author: Excalibra
Homepage: https://github.com/Excalibra
'''

# Set the Qt platform plugin path
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# Get computer name
hostname = socket.gethostname()
# Get IP address
Compute_addr = socket.gethostbyname(hostname)
# Get login username
userName = getpass.getuser()

show = f'Screen Watermark-{hostname}-{userName}-{Compute_addr}'

# Custom window class for displaying watermark
class WatermarkWindow(QWidget):
    def __init__(self, position, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # Set transparency to 40%

        # Get screen dimensions
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # Set window to full screen

        # Create watermark label
        self.label = QLabel(self)
        self.label.setText(show)
        self.label.setFont(QFont('Arial', 23))
        self.label.setStyleSheet('color: #708090;')

        # Use layout to position the label
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)  # Remove layout margins

        if position == 'nw':
            layout.setAlignment(Qt.AlignTop | Qt.AlignLeft)  # Top-left
        elif position == 'sw':
            layout.setAlignment(Qt.AlignBottom | Qt.AlignLeft)  # Bottom-left
        elif position == 'ne':
            layout.setAlignment(Qt.AlignTop | Qt.AlignRight)  # Top-right
        elif position == 'se':
            layout.setAlignment(Qt.AlignBottom | Qt.AlignRight)  # Bottom-right
        elif position == 'center':
            layout.setAlignment(Qt.AlignCenter)  # Center
        elif position == 'e':
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignRight)  # Middle-right
        elif position == 'w':
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignLeft)  # Middle-left

        layout.addWidget(self.label)  # Add label to layout

    def paintEvent(self, event):
        # No need to manually draw the background or text; use layout and alignment to handle it automatically
        pass


def create_windows():
    windows = []
    positions = ['nw', 'sw', 'center', 'ne', 'se', 'nw', 'sw', 'e', 'w', 'ne', 'se']
    for position in positions:
        window = WatermarkWindow(position)
        window.show()
        windows.append(window)
    return windows


if __name__ == '__main__':
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Do not display")
    else:
        app = QApplication(sys.argv)
        windows = create_windows()
        sys.exit(app.exec_())  # Launch the application
