import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter, QFont
import hostname_user_ip_date

'''
Author: hoochanlon
Homepage: https://github.com/hoochanlon
'''

# Set the Qt platform plugin path
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# Get the computer name and username
hostname, username = hostname_user_ip_date.get_hostname_username()

# Get the IP address
compute_addr = hostname_user_ip_date.get_preferred_ip()

# Get the current date
current_date = hostname_user_ip_date.get_current_date()

# Define the watermark text to display
show = f'Screen Watermark-{hostname}-{username}-{current_date}-{compute_addr}'


class WatermarkWindow(QWidget):
    def __init__(self, position, pady=0, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # Opacity set to 40%

        # Get screen width and height
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # Set the window to fullscreen
        self.position = position
        self.pady = pady
        self.padx = padx

    def paintEvent(self, event):
        """Custom method to draw the watermark text with a 45-degree tilt"""
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)  # Enable anti-aliasing
        painter.setFont(QFont("Arial", 23))  # Set font and size

        # Save the current painter state
        painter.save()

        # Get the current window width and height
        w = self.width()
        h = self.height()

        # Adjust text rendering offset based on the position
        if self.position == 'nw':
            watermark_text = f'Top Left-{show}'  # Add directional marker
            painter.translate(self.padx, self.pady)  # Top-left offset
        elif self.position == 'sw':
            watermark_text = f'Bottom Left-{show}'  # Add directional marker
            painter.translate(self.padx, h - self.pady)  # Bottom-left offset
        elif self.position == 'ne':
            watermark_text = f'Top Right-{show}'  # Add directional marker
            painter.translate(w - self.padx, self.pady)  # Top-right offset
        elif self.position == 'se':
            watermark_text = f'Bottom Right-{show}'  # Add directional marker
            painter.translate(w - self.padx, h - self.pady)  # Bottom-right offset
        elif self.position == 'center':
            watermark_text = f'Center-{show}'  # Add directional marker
            painter.translate(w / 2 + self.padx, h / 2 + self.pady)  # Center position offset
        elif self.position == 'e':
            watermark_text = f'Middle Right-{show}'  # Add directional marker
            painter.translate(w - self.padx - 50, h / 2 + self.pady)  # Adjust offset for visibility
        elif self.position == 'w':
            watermark_text = f'Middle Left-{show}'  # Add directional marker
            painter.translate(self.padx + 50, h / 2 + self.pady)  # Adjust offset for visibility

        # Add a new bottom-right watermark
        elif self.position == 'right_bottom':
            watermark_text = f'New Bottom Right-{show}'  # Add directional marker
            painter.translate(w - self.padx, h - self.pady)  # Bottom-right offset

        painter.rotate(-45)  # Set tilt angle
        painter.setPen(Qt.gray)

        # Draw the watermark text
        painter.drawText(0, 0, watermark_text)  # Use the updated watermark text
        painter.restore()


def create_windows():
    windows = []

    # Define offsets for each position
    positions = [
        ('nw', 50, 50),  # Top left corner, offsets (pady, padx)
        ('sw', 100, 50),  # Bottom left corner, offsets (pady, padx)
        ('ne', 50, 150),  # Top right corner, offsets (pady, padx)
        ('se', 100, 150),  # Bottom right corner, offsets (pady, padx)
        ('center', 150, 0),  # Center, offsets (pady, padx)
        ('w', 0, 0),     # Middle left, offsets (pady, padx)
        ('e', 100, 400),    # Middle right, offsets (pady, padx)
        ('right_bottom', 100, 100)  # New bottom-right watermark, offsets (pady, padx)
    ]

    for position, pady, padx in positions:
        window = WatermarkWindow(position, pady=pady, padx=padx)
        window.show()
        windows.append(window)

    return windows


if __name__ == '__main__':
    app = QApplication(sys.argv)
    windows = create_windows()
    sys.exit(app.exec_())
