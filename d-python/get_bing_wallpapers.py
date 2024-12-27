import requests
import os

# Headers to simulate a browser request
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"
}

# Define the directory to save images
default_pictures_dir = os.path.join(os.path.expanduser("~"), "Pictures")
picture_path = os.path.join(default_pictures_dir, "bing")

# Create the directory if it doesn't exist
if not os.path.exists(picture_path):
    os.makedirs(picture_path)

# Fetch the last 4 days of wallpapers (starting with today)
for idx in range(4):
    # Request to Bing API for wallpaper metadata
    api_url = f"https://www.bing.com/HPImageArchive.aspx?format=js&idx={idx}&n=1&mkt=en-US"
    response = requests.get(api_url, headers=headers)
    if response.status_code != 200:
        print(f"Failed to fetch data for idx={idx}, skipping.")
        continue
    
    data = response.json()
    if not data.get("images"):
        print(f"No images found for idx={idx}, skipping.")
        continue

    # Extract image URL and other details
    image_info = data["images"][0]
    image_url = "https://www.bing.com" + image_info["url"]
    image_name = image_info["urlbase"].split("/")[-1] + ".jpg"
    save_path = os.path.join(picture_path, image_name)

    # Download the image
    image_response = requests.get(image_url, headers=headers)
    if image_response.status_code == 200:
        with open(save_path, "wb") as f:
            f.write(image_response.content)
        print(f"Downloaded: {save_path}")
    else:
        print(f"Failed to download image for idx={idx}.")
