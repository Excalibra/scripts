# screen_watermark_qt5.py
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

# Get the computer name
hostname = socket.gethostname()
# Get the IP address
Compute_addr = socket.gethostbyname(hostname)
# Get the username of the logged-in user
userName = getpass.getuser()

show = f'Screen Watermark-{hostname}-{userName}-{Compute_addr}'

# Custom window class for displaying the watermark
class WatermarkWindow(QWidget):
    def __init__(self, position, pady=100, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # Transparency set to 40%

        # Get screen dimensions
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # Set window to full screen

        # Create watermark label
        self.label = QLabel(self)
        self.label.setText(show)
        self.label.setFont(QFont('Arial', 23))  # Changed font for better compatibility
        self.label.setStyleSheet('color: #708090;')

        # Use layout to set label position
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)  # Remove layout margins

        # Set watermark position
        if position == 'nw':  # Top-left corner
            layout.setAlignment(Qt.AlignTop | Qt.AlignLeft)  # Align watermark to the top-left
            layout.setContentsMargins(padx, pady, 0, 0)  # Control top-left margin
        elif position == 'sw':  # Bottom-left corner
            layout.setAlignment(Qt.AlignBottom | Qt.AlignLeft)  # Align watermark to the bottom-left
            layout.setContentsMargins(padx, 0, 0, pady)  # Control bottom-left margin
        elif position == 'ne':  # Top-right corner
            layout.setAlignment(Qt.AlignTop | Qt.AlignRight)  # Align watermark to the top-right
            layout.setContentsMargins(0, pady, padx, 0)  # Control top-right margin
        elif position == 'se':  # Bottom-right corner
            layout.setAlignment(Qt.AlignBottom | Qt.AlignRight)  # Align watermark to the bottom-right
            layout.setContentsMargins(0, 0, padx, 100)  # Control bottom-right margin
        elif position == 'center':  # Center of the screen
            layout.setAlignment(Qt.AlignCenter)  # Center-align watermark
        elif position == 'e':  # Right-middle
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignRight)  # Vertically center and align right
        elif position == 'w':  # Left-middle
            layout.setAlignment(Qt.AlignVCenter | Qt.AlignLeft)  # Vertically center and align left

        layout.addWidget(self.label)  # Add label to layout

    def paintEvent(self, event):
        # No need to manually draw background or text; layout and alignment handle it
        pass


def create_windows():
    windows = []
    positions = [
        'nw', 'sw', 'center', 'ne', 'se',  # Four corners and center
        'nw', 'sw',  # Repeat top-left and bottom-left watermarks (can add multiple watermarks)
        'e', 'w',    # Add watermarks to right-middle and left-middle
        'ne', 'se'   # Repeat top-right and bottom-right watermarks
    ]  # List of watermark positions

    # Create each window and specify corresponding margins and positions
    for position in positions:
        window = WatermarkWindow(position)  # Create watermark window
        window.show()  # Display the watermark window
        windows.append(window)  # Add window to the list

    # Add a second bottom-left watermark
    sw2_window = WatermarkWindow('sw', pady=200)  # Create another bottom-left watermark with a different pady
    sw2_window.show()  # Display the second bottom-left watermark
    windows.append(sw2_window)  # Add to the window list
    
    return windows


if __name__ == '__main__':
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Watermark not displayed")  # If file exists, do not display watermark
    else:
        app = QApplication(sys.argv)
        windows = create_windows()  # Create watermark windows
        sys.exit(app.exec_())  # Start the application
