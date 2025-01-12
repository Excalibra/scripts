import os
import sys
import screen_watermark_tkinter
import screen_watermark_qt5
import screen_watermark_qt5_oblique

def qt5_effect():
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Not displayed")  # If the file exists, do not display the watermark
    else:
        app = screen_watermark_qt5.QApplication(sys.argv)
        windows = screen_watermark_qt5.create_windows()  # Create watermark windows
        sys.exit(app.exec_())  # Start the application

def tkinter_effect():
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Not displayed")
    else:
        windows = screen_watermark_tkinter.create_watermark_windows()
        for window in windows:
            window.mainloop()  # Loop to display each window

def qt5_oblique_effect():
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Not displayed")  # If the file exists, do not display the watermark
    else:
        app = screen_watermark_qt5_oblique.QApplication(sys.argv)
        windows = screen_watermark_qt5_oblique.create_windows()  # Create watermark windows
        sys.exit(app.exec_())  # Start the application

if __name__ == '__main__':
    qt5_effect()  # Test qt5 implementation effect
    # tkinter_effect() # Test tkinter implementation effect
    # qt5_oblique_effect() # Test qt5_oblique implementation effect
