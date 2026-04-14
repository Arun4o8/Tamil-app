import re

with open(r"c:\Users\DEEPAK\Desktop\DanceWebsite\viewer.html", "r", encoding="utf-8") as f:
    text = f.read()

images = re.findall(r'<img[^>]+src="([^"]+)"', text)
for img in images:
    if "unsplash" in img:
        print("UNSPLASH IMAGE FOUND:", img)
print("TOTAL IMAGES:", len(images))
