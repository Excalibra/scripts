import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter, QFont
import hostname_user_ip_date

'''
Author: Excalibra
Homepage: https://github.com/Excalibra
'''

# Set the Qt platform plugin path
qt_plugin_path = os.path.join(os.path.expanduser("~"), "AppData", "Local", "Programs", "Python", "Python313", "Lib", "site-packages", "PyQt5", "Qt5", "plugins", "platforms")
os.environ['QT_QPA_PLATFORM_PLUGIN_PATH'] = qt_plugin_path

# Get computer name and username
hostname, username = hostname_user_ip_date.get_hostname_username()

# Get IP address
compute_addr = hostname_user_ip_date.get_preferred_ip()

# Get current date
current_date = hostname_user_ip_date.get_current_date()

# Define the watermark text to display
show = f'Screen Watermark-{hostname}-{username}-{current_date}-{compute_addr}'


class WatermarkWindow(QWidget):
    def __init__(self, position, pady=0, padx=0, parent=None):
        super().__init__(parent)
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool)
        self.setAttribute(Qt.WA_TranslucentBackground)
        self.setWindowOpacity(0.4)  # Set transparency to 40%

        # Get screen dimensions
        screen_geometry = QApplication.desktop().screenGeometry()
        self.setGeometry(screen_geometry)  # Set window to full screen
        self.position = position
        self.pady = pady
        self.padx = padx

    def paintEvent(self, event):
        """Custom method to draw the watermark text with a 45-degree tilt"""
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)  # Enable anti-aliasing for smoother rendering
        painter.setFont(QFont("Arial", 23))  # Set font and size

        # Save the current state
        painter.save()

        # Get the width and height of the current window
        w = self.width()
        h = self.height()

        # Adjust text rendering offset based on the position
        if self.position == 'nw':
            watermark_text = f'Top-left-{show}'  # Add directional tag
            painter.translate(self.padx, self.pady)  # Offset for the top-left corner
        elif self.position == 'sw':
            watermark_text = f'Bottom-left-{show}'  # Add directional tag
            painter.translate(self.padx, h - self.pady)  # Offset for the bottom-left corner
        elif self.position == 'ne':
            watermark_text = f'Top-right-{show}'  # Add directional tag
            painter.translate(w - self.padx, self.pady)  # Offset for the top-right corner
        elif self.position == 'se':
            watermark_text = f'Bottom-right-{show}'  # Add directional tag
            painter.translate(w - self.padx, h - self.pady)  # Offset for the bottom-right corner
        elif self.position == 'center':
            watermark_text = f'Center-{show}'  # Add directional tag
            painter.translate(w / 2 + self.padx, h / 2 + self.pady)  # Offset for the center
        elif self.position == 'e':
            watermark_text = f'Middle-right-{show}'  # Add directional tag
            painter.translate(w - self.padx - 50, h / 2 + self.pady)  # Adjust offset to make watermark visible
        elif self.position == 'w':
            watermark_text = f'Middle-left-{show}'  # Add directional tag
            painter.translate(self.padx + 50, h / 2 + self.pady)  # Adjust offset to make watermark visible

        painter.rotate(-45)  # Set tilt angle
        painter.setPen(Qt.gray)

        # Draw the watermark text
        painter.drawText(0, 0, watermark_text)  # Use the updated watermark text
        painter.restore()


def create_windows():
    windows = []

    # Define offsets for each position
    positions = [
        ('nw', 50, 50),  # Top-left corner, offset (pady, padx)
        ('sw', 100, 50),  # Bottom-left corner, offset (pady, padx)
        ('ne', 50, 150),  # Top-right corner, offset (pady, padx)
        ('se', 100, 150),  # Bottom-right corner, offset (pady, padx)
        ('center', 0, 0),  # Center, offset (pady, padx)
        ('e', 0, 0),    # Middle-right, offset (pady, padx)
        ('w', 0, 0)      # Middle-left, offset (pady, padx)
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
