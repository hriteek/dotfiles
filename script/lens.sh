#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Checking if Lens is already installed..."
if command -v lens >/dev/null 2>&1; then
  echo "✅ Lens is already installed."
  exit 0
fi

echo "🔧 Installing prerequisites..."
sudo apt-get update -qq
sudo apt-get install -y -qq curl gnupg apt-transport-https

# Add Lens GPG key if not already present
KEYRING_DIR="/usr/share/keyrings"
KEY_FILE="$KEYRING_DIR/lens-archive-keyring.gpg"
if [[ ! -f "$KEY_FILE" ]]; then
  echo "🔐 Adding Lens GPG key..."
  curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee "$KEY_FILE" >/dev/null
  sudo chmod 644 "$KEY_FILE"
else
  echo "✅ Lens GPG key already exists."
fi

# Add Lens APT repository
REPO_FILE="/etc/apt/sources.list.d/lens-desktop.list"
if [[ ! -f "$REPO_FILE" ]]; then
  echo "➕ Adding Lens APT repository..."
  echo "deb [signed-by=$KEY_FILE arch=$(dpkg --print-architecture)] https://downloads.k8slens.dev/apt/ stable main" |
    sudo tee "$REPO_FILE" >/dev/null
else
  echo "✅ Lens APT source already exists."
fi

# Update and install Lens
echo "🔄 Updating package list..."
sudo apt-get update -qq

echo "📦 Installing Lens Desktop..."
sudo apt-get install -y -qq lens-desktop

echo "🎉 Lens Desktop installed successfully!"
