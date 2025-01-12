import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter, QFont
import hostname_user_ip_date

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
