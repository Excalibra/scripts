# Adding Watermarks to the Screen

Due to the noticeable jagged edges in text rendering when using Tkinter for desktop watermarks, the implementation was rewritten using Qt5. The original Tkinter implementation has also been retained for reference.

---

## Key Features

### 1. Transparent Full-Screen Windows  
The program creates multiple full-screen transparent windows matching the size of the screen. By removing the window borders and title bar, the windows appear frameless.

### 2. Semi-Transparent Content  
The windows are semi-transparent, ensuring they do not obstruct the visibility of other applications. The background colour of the window is initially set to white, which is later rendered transparent.

### 3. Watermark Placement and Always-On-Top Setting  
The program allows control over the position of the watermark within the window. It ensures that the watermark window always appears above all other application windows, preventing it from being covered.

### 4. Non-Interactive Transparency  
The transparent windows do not receive user clicks or interactions. They function solely as a visual element, ensuring the watermark does not interfere with user operations.

---

## Demonstration of Effects

### Tkinter Implementation  
![Tkinter Effect](#)

### Qt5 Implementation  
![Qt5 Effect](#)  
![Qt5 Oblique Effect](#)

---

## How to Use

### Install Dependencies  
Generate and install the required environment dependencies with the following commands:  

```
pip freeze > requirements.txt
pip install -r requirements.txt
```

## Run the Program

Execute the script to view the effects: `python main.py`

Inside `main.py`, you can toggle between different effects:

```
if __name__ == '__main__':
    qt5_effect()  # View the Qt5 implementation
    # tkinter_effect() # View the Tkinter implementation
    # qt5_oblique_effect() # View the oblique watermark effect in Qt5
```

Scripts like `screen_watermark_qt5.py` and `screen_watermark_tkinter.py` can be modified according to your needs.

## Packaging with PyInstaller

To create an executable file using PyInstaller, use the following command:

```
pyinstaller -w -F -i "C:\Users\administrator\Desktop\watermark\images\logo.ico" --onefile ^
--add-data "C:\Users\administrator\Desktop\watermark\images;images" ^
--name "屏幕加水印" --distpath "C:\Users\administrator\Desktop" "C:\Users\administrator\Desktop\watermark\main.py"
```

This generates a standalone executable with the specified icon and ensures the watermark assets are included.










