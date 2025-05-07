#!/bin/bash

# Setup script for Dust Nintendo DS Emulator
# This script will:
# 1. Clone the web-deploy branch of the Dust repository to the current directory
# 2. Setup and start a Python HTTP server to serve the emulator

# Print colored messages
print_message() {
  echo -e "\e[1;34m>> $1\e[0m"
}

print_success() {
  echo -e "\e[1;32m✓ $1\e[0m"
}

print_error() {
  echo -e "\e[1;31m✗ $1\e[0m"
}

# Create a directory for the emulator in the current directory
DUST_DIR="./dust-web"

# Check if directory already exists
if [ -d "$DUST_DIR" ]; then
  print_message "Dust directory already exists. Removing..."
  rm -rf "$DUST_DIR"
fi

# Step 1: Clone the web-deploy branch
print_message "Cloning Dust emulator web-deploy branch..."
git clone -b web-deploy --single-branch https://github.com/kelpsyberry/dust.git "$DUST_DIR"

if [ $? -ne 0 ]; then
  print_error "Failed to clone repository!"
  exit 1
fi
print_success "Repository cloned successfully."

# Step 2: Create the startup script
print_message "Creating startup script..."

cat > run_dust.sh << 'EOF'
#!/bin/bash

# Change to the dust-web directory (using relative path from where the script is run)
cd dust-web

# Run the server on port 5000 using Python's built-in HTTP server
echo -e "\e[1;34mStarting Dust DS Emulator at http://localhost:5000\e[0m"
echo -e "\e[1;34mPlease open this URL in your browser\e[0m"
echo -e "\e[1;34mPress Ctrl+C to stop the server\e[0m"

# Find which Python command is available
if command -v python &> /dev/null; then
  python -m http.server 5000
elif command -v python3 &> /dev/null; then
  python3 -m http.server 5000
else
  echo -e "\e[1;31mError: Python not found!\e[0m"
  exit 1
fi
EOF

chmod +x run_dust.sh
print_success "Startup script created."

# Step 3: Create a guide
print_message "Creating usage guide..."

cat > dust_emulator_guide.md << 'EOF'
# Dust Nintendo DS Emulator Guide

## Starting the Emulator
1. Run the startup script from the directory where you ran the setup:
   ```
   ./run_dust.sh
   ```
2. The server will start on port 5000
3. Open http://localhost:5000 in your browser

## Using the Emulator
1. Upload a Nintendo DS ROM file using the file picker in the interface
2. The emulator will automatically start running the game
3. Use the on-screen controls or configure keyboard controls in the settings

## Troubleshooting White Screen Issues
If you see a white screen after loading a ROM:

1. Check your browser console for errors (F12 > Console)
2. Try a different ROM file - some ROMs may not be compatible
3. Make sure you're using a modern browser (Chrome/Edge recommended)
4. Try disabling any browser extensions that might interfere
5. Try restarting the emulator server and refreshing the page

## Keyboard Controls (Default)
- Arrow keys: D-Pad
- X/Y: A/B buttons
- A/S: X/Y buttons
- Q/W: L/R buttons
- Enter: Start
- Space: Select
- Tab: Toggle menu

## Additional Tips
- If you get a black screen, try checking if your ROM file is valid
- You can save and load game states using the menu
- For better performance, use Chrome or Edge browsers
- Some games may be too demanding to run smoothly in the browser version
EOF

print_success "Guide created at ./dust_emulator_guide.md"

# Step 4: Instructions
print_message "Setup complete!"
print_message "Run the emulator with: ./run_dust.sh"
print_message "See the guide at: ./dust_emulator_guide.md"

# Final instructions
echo ""
print_message "IMPORTANT: In GitHub Codespaces, make sure port 5000 is forwarded:"
echo "1. Look for the 'Ports' tab in the bottom panel"
echo "2. If port 5000 is not listed, click 'Add Port' and enter 5000"
echo "3. Click the globe icon next to port 5000 to open the emulator in your browser"
echo ""

# Ask if user wants to start emulator now
read -p "Do you want to start the emulator now? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
  ./run_dust.sh
else
  print_message "You can start the emulator later by running: ./run_dust.sh"
fi