# Create placeholder images for development
# This creates simple colored placeholder images for missing assets

# Create a simple favicon
echo "Creating favicon..."
echo "data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' fill='%230f1b5e'/><text x='16' y='20' text-anchor='middle' fill='white' font-family='Arial' font-size='12' font-weight='bold'>Q</text></svg>" > src/favicon.ico

# Create placeholder images using ImageMagick or simple colored rectangles
if command -v convert &> /dev/null; then
    echo "Creating placeholder images with ImageMagick..."
    convert -size 800x400 xc:'#0f1b5e' -pointsize 48 -fill white -gravity center -annotate +0+0 'About Preview' src/images/about-preview.jpg
    convert -size 800x400 xc:'#0f1b5e' -pointsize 48 -fill white -gravity center -annotate +0+0 'Research Image' src/images/research1.jpg
else
    echo "ImageMagick not available, creating simple placeholder files..."
    # Create simple placeholder files
    echo "Placeholder for about-preview.jpg" > src/images/about-preview.jpg
    echo "Placeholder for research1.jpg" > src/images/research1.jpg
fi

echo "Placeholder images created successfully!"
