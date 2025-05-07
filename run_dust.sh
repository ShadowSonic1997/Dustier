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
