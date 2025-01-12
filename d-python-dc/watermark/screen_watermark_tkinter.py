# screen_watermark_tkinter.py
import tkinter, win32api, win32con, pywintypes, os
import socket
import getpass
import tkinter.font as tkFont
import platform
import hostname_user_ip_date

'''
Author: Excalibra
Homepage: https://github.com/Excalibra
'''

# Get the computer name and username
hostname, username = hostname_user_ip_date.get_hostname_username()

# Get the IP address
compute_addr = hostname_user_ip_date.get_preferred_ip()

# Get the current date
current_date = hostname_user_ip_date.get_current_date()

# show = 'Screen Watermark-{}-{}-{}-{}'.format(hostname, username, current_date, compute_addr)
show = 'Screen Watermark-{}-{}-{}'.format(hostname, username, compute_addr)


# Configure the window transparency and other settings
def setup_window(root_window):
    root_window.overrideredirect(True)  # Hide window frame
    root_window.attributes("-alpha", 0.4)  # Set window transparency to 40%
    w = root_window.winfo_screenwidth()
    h = root_window.winfo_screenheight()
    root_window.geometry("%dx%d" % (w, h))
    root_window.lift()  # Bring window to the top layer
    root_window.wm_attributes("-topmost", True)  # Always stay on top
    root_window.wm_attributes("-disabled", True)
    root_window.wm_attributes("-transparentcolor", "white")  # Make white background transparent
    hWindow = pywintypes.HANDLE(int(root_window.frame(), 16))  # Convert frame to handle
    exStyle = win32con.WS_EX_COMPOSITED | win32con.WS_EX_LAYERED | win32con.WS_EX_NOACTIVATE | win32con.WS_EX_TOPMOST | win32con.WS_EX_TRANSPARENT
    win32api.SetWindowLong(hWindow, win32con.GWL_EXSTYLE, exStyle)


def create_watermark_windows():
    # Create and configure windows
    windows = [tkinter.Tk() for _ in range(12)]  # Create 12 windows

    # Set up each window
    for window in windows:
        setup_window(window)

    # Set watermark labels
    tkinter.Label(windows[0], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw').pack()  # Top left
    tkinter.Label(windows[1], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw').pack()  # Bottom left
    tkinter.Label(windows[3], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='center').pack()  # Center
    tkinter.Label(windows[4], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne').pack()  # Top right
    tkinter.Label(windows[5], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se').pack()  # Bottom right

    # Add watermarks for new positions
    tkinter.Label(windows[6], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw', pady=50).pack()  # Top left with padding
    tkinter.Label(windows[7], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw', pady=50).pack()  # Bottom left with padding
    tkinter.Label(windows[8], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='e').pack()  # Middle right
    tkinter.Label(windows[9], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='w').pack()  # Middle left
    tkinter.Label(windows[10], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne', pady=50).pack()  # Top right with padding
    tkinter.Label(windows[11], text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se', pady=50).pack()  # Bottom right with padding

    return windows


if __name__ == '__main__':
    # Check if the file exists
    Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
    current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
    exists = os.path.exists(current_dir)

    if exists:
        print("Watermark not displayed")
    else:
        windows = create_watermark_windows()
        for window in windows:
            window.mainloop()  # Loop to display each window
