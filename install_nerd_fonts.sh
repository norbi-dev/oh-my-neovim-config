#!/bin/bash

# Define the font name and download URL
FONT_NAME="JetBrainsMono"
URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts/jetbrains-nerd"

echo "Creating font directory at $FONT_DIR..."
mkdir -p "$FONT_DIR"

echo "Downloading $FONT_NAME Nerd Font..."
wget -q --show-progress "$URL" -O "${FONT_NAME}.zip"

echo "Unzipping fonts..."
unzip -o "${FONT_NAME}.zip" -d "$FONT_DIR"

echo "Cleaning up..."
rm "${FONT_NAME}.zip"
rm "$FONT_DIR/"*Windows* # Optional: remove Windows-specific files

echo "Updating font cache..."
fc-cache -fv

echo "------------------------------------------------------"
echo "DONE! JetBrains Mono Nerd Font is installed."
echo "Now you MUST change the font in Xfce Terminal settings."
echo "------------------------------------------------------"