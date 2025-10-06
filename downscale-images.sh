#!/bin/bash

# Downscale images for memory card game
# Reduces file size while maintaining quality for web display

# Configuration
TARGET_WIDTH=400        # Target width in pixels (maintains aspect ratio)
QUALITY=85             # JPEG quality (0-100, 85 is good balance)
MEDIA_DIR="media"
BACKUP_DIR="media/originals"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🖼️  Image Downscaling Script${NC}"
echo "================================"
echo ""

# Create backup directory
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${GREEN}Creating backup directory...${NC}"
    mkdir -p "$BACKUP_DIR"
fi

# Process each JPG file
for img in "$MEDIA_DIR"/*.jpg "$MEDIA_DIR"/*.JPG; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")

        # Skip if already in originals directory
        if [[ "$img" == *"/originals/"* ]]; then
            continue
        fi

        # Get current dimensions
        current_width=$(sips -g pixelWidth "$img" | tail -1 | awk '{print $2}')
        current_size=$(du -h "$img" | awk '{print $1}')

        echo -e "${BLUE}Processing:${NC} $filename"
        echo "  Current: ${current_width}px, $current_size"

        # Backup original if not already backed up
        if [ ! -f "$BACKUP_DIR/$filename" ]; then
            cp "$img" "$BACKUP_DIR/$filename"
            echo "  ✓ Backed up to $BACKUP_DIR/"
        fi

        # Downscale image
        sips --resampleWidth $TARGET_WIDTH \
             --setProperty format jpeg \
             --setProperty formatOptions $QUALITY \
             "$img" --out "$img" > /dev/null 2>&1

        new_size=$(du -h "$img" | awk '{print $1}')
        echo -e "  ${GREEN}✓ Resized to ${TARGET_WIDTH}px, $new_size${NC}"
        echo ""
    fi
done

echo "================================"
echo -e "${GREEN}✨ Done! Originals saved in $BACKUP_DIR/${NC}"
echo ""
echo "To restore originals: cp $BACKUP_DIR/* $MEDIA_DIR/"
