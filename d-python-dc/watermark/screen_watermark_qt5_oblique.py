import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter, QFont
import hostname_user_ip_date


if __name__ == '__main__':
    app = QApplication(sys.argv)
    windows = create_windows()
    sys.exit(app.exec_())
