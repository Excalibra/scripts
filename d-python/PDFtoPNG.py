import os
import fitz  # PyMuPDF
import PySimpleGUI as sg

def pdf_to_png(pdf_path, image_path):
    # Extract the file name from the PDF path to use as the folder name
    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
    dir = os.path.join(image_path, pdf_name)
    if not os.path.exists(dir):
        os.makedirs(dir)

    # Open the PDF file
    doc = fitz.open(pdf_path)
    for i in range(len(doc)):
        page = doc[i]
        pix = page.get_pixmap()  # Convert the page to a pixmap (image)
        imageSavePath = os.path.join(dir, f"{pdf_name}_{i}.png")
        pix.save(imageSavePath)  # Save the image as a PNG file

def convert_to_png(pdf_path, image_path):
    pdf_name = os.path.splitext(os.path.basename(pdf_path))[0]
    pdf_to_png(pdf_path, image_path)
    sg.popup("Conversion complete!", title="PDF to PNG", font=("Helvetica", 16))

# Create the window layout
layout = [
    [sg.Text("Select the PDF file to convert", font=("Helvetica", 16))],
    [sg.Input(key="-FILE-", enable_events=True), sg.FileBrowse(file_types=(("PDF Files", "*.pdf"),), button_text="Browse")],
    [sg.Button("Convert", key="-CONVERT-")]
]

# Create the window
window = sg.Window("PDF to PNG Converter", layout)

# Event loop
while True:
    event, values = window.read()

    if event == sg.WINDOW_CLOSED:
        break
    elif event == "-CONVERT-":
        pdf_path = values["-FILE-"]
        if pdf_path:  # Ensure a file is selected
            convert_to_png(pdf_path, os.path.expanduser("~/Desktop"))
        else:
            sg.popup("Please select a PDF file first!", title="Error", font=("Helvetica", 16))

window.close()
