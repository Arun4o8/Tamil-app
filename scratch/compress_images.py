import os
from PIL import Image

def compress_images(directory, quality=70):
    for filename in os.listdir(directory):
        if filename.endswith(".png"):
            filepath = os.path.join(directory, filename)
            try:
                with Image.open(filepath) as img:
                    # If it has an alpha channel, convert to RGB first (for JPEG)
                    if img.mode in ('RGBA', 'P'):
                        img = img.convert('RGB')
                    
                    new_filename = filename.replace(".png", ".jpg")
                    new_filepath = os.path.join(directory, new_filename)
                    img.save(new_filepath, "JPEG", quality=quality)
                    print(f"Compressed {filename} -> {new_filename}")
                    # Remove the old PNG
                    os.remove(filepath)
            except Exception as e:
                print(f"Error processing {filename}: {e}")

# Compress dance images
compress_images("assets/images/dances")
# Compress backgrounds in root assets
compress_images("assets")
# Compress app common images
compress_images("assets/images/app")
