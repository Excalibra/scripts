# screen_watermark_tkinter_old.py
import tkinter, win32api, win32con, pywintypes, os
import socket
import getpass
import tkinter.font as tkFont
import platform

'''
Author: hoochanlon
Homepage: https://github.com/hoochanlon
'''

# Get computer name
hostname = socket.gethostname()
# Get IP address
Compute_addr = socket.gethostbyname(hostname)  # Get IP
print(Compute_addr)

# Get login username
userName = getpass.getuser()

show = 'Screen Watermark-{}-{}-{}'.format(hostname, userName, Compute_addr)


# Set up window transparency and other properties
def setup_window(root_window):
    root_window.overrideredirect(True)  # Hide the title bar
    root_window.attributes("-alpha", 0.4)  # Set window transparency to 40%
    w = root_window.winfo_screenwidth()
    h = root_window.winfo_screenheight()
    root_window.geometry("%dx%d" % (w, h))
    root_window.lift()  # Bring the window to the top
    root_window.wm_attributes("-topmost", True)  # Keep the window always on top
    root_window.wm_attributes("-disabled", True)
    root_window.wm_attributes("-transparentcolor", "white")  # Make the white background transparent
    hWindow = pywintypes.HANDLE(int(root_window.frame(), 16))  # Get the window handle
    exStyle = win32con.WS_EX_COMPOSITED | win32con.WS_EX_LAYERED | win32con.WS_EX_NOACTIVATE | win32con.WS_EX_TOPMOST | win32con.WS_EX_TRANSPARENT
    win32api.SetWindowLong(hWindow, win32con.GWL_EXSTYLE, exStyle)


# Create additional windows
root1 = tkinter.Tk()
root2 = tkinter.Tk()
root3 = tkinter.Tk()
root4 = tkinter.Tk()
root5 = tkinter.Tk()  # Newly added window
root6 = tkinter.Tk()  # Newly added window
root7 = tkinter.Tk()  # Newly added window
root8 = tkinter.Tk()  # Newly added window
root9 = tkinter.Tk()  # Newly added window
root10 = tkinter.Tk()  # Newly added window
root11 = tkinter.Tk()  # Newly added window

# Set up each window
setup_window(root1)
setup_window(root2)
setup_window(root3)
setup_window(root4)
setup_window(root5)  # Configure new window
setup_window(root6)  # Configure new window
setup_window(root7)  # Configure new window
setup_window(root8)  # Configure new window
setup_window(root9)  # Configure new window
setup_window(root10)  # Configure new window
setup_window(root11)  # Configure new window


# Set watermark labels
tkinter.Label(root1, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw').pack()  # Top-left
tkinter.Label(root2, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw').pack()  # Bottom-left
tkinter.Label(root3, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='center').pack()  # Center
tkinter.Label(root4, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne').pack()  # Top-right
tkinter.Label(root5, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se').pack()  # Bottom-right


# Additional watermark positions
tkinter.Label(root6, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='nw', pady=50).pack()  # Top-left with padding
tkinter.Label(root7, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='sw', pady=50).pack()  # Bottom-left with padding
tkinter.Label(root8, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='e').pack()  # Middle-right
tkinter.Label(root9, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='w').pack()  # Middle-left
tkinter.Label(root10, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='ne', pady=50).pack()  # Top-right with padding
tkinter.Label(root11, text=show, font=('Arial', '23', 'normal'), fg='#708090', bg='white', width=1000, height=1000, anchor='se', pady=50).pack()  # Bottom-right with padding


Desktop_dir = os.path.join(os.path.expanduser("~"), "Desktop")
current_dir = os.path.join(Desktop_dir, "no_screen_mark.ini")
exists = os.path.exists(current_dir)

if exists:
    print("Do not display")
else:
    root1.mainloop()  # Loop
    root2.mainloop()  # Loop
    root3.mainloop()  # Loop
    root4.mainloop()  # Loop
    root5.mainloop()  # Loop
    root6.mainloop()  # Loop
    root7.mainloop()  # Loop
    root8.mainloop()  # Loop
    root9.mainloop()  # Loop
    root10.mainloop()  # Loop
    root11.mainloop()  # Loop
