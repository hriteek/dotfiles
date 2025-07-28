#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Installing prerequisites..."
sudo apt-get update -qq
sudo apt-get install -y -qq wget gpg apt-transport-https

# Set up keyring directory and Microsoft GPG key
KEYRING_DIR="/etc/apt/keyrings"
KEY_FILE="$KEYRING_DIR/packages.microsoft.gpg"

if [[ ! -f "$KEY_FILE" ]]; then
  echo "🔐 Adding Microsoft's GPG key..."
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee "$KEY_FILE" >/dev/null
  sudo chmod 644 "$KEY_FILE"
else
  echo "✅ Microsoft GPG key already exists."
fi

# Add VS Code repository if not already added
REPO_FILE="/etc/apt/sources.list.d/vscode.list"
if [[ ! -f "$REPO_FILE" ]]; then
  echo "➕ Adding VS Code repository..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEY_FILE] https://packages.microsoft.com/repos/code stable main" |
    sudo tee "$REPO_FILE" >/dev/null
else
  echo "✅ VS Code repository already exists."
fi

# Update APT and install VS Code (stable or insiders)
echo "📦 Installing Visual Studio Code..."
sudo apt-get update -qq

# Choose either one, or both if you really want
if ! command -v code >/dev/null 2>&1; then
  sudo apt-get install -y -qq code && echo "✅ VS Code installed."
else
  echo "✅ VS Code already installed."
fi

if ! command -v code-insiders >/dev/null 2>&1; then
  sudo apt-get install -y -qq code-insiders && echo "✅ VS Code Insiders installed."
else
  echo "✅ VS Code Insiders already installed."
fi
