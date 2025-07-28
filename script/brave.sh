#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Checking if Brave is already installed..."
if command -v brave-browser >/dev/null 2>&1; then
  echo "✅ Brave Browser is already installed."
  exit 0
fi

echo "🔧 Installing curl if not already installed..."
sudo apt-get update -qq
sudo apt-get install -y -qq curl

# Download and install Brave's GPG key
KEYRING_PATH="/usr/share/keyrings/brave-browser-archive-keyring.gpg"
if [[ ! -f "$KEYRING_PATH" ]]; then
  echo "🔐 Adding Brave GPG key..."
  sudo curl -fsSLo "$KEYRING_PATH" https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
else
  echo "✅ Brave GPG key already exists."
fi

# Add Brave source list
SOURCE_LIST="/etc/apt/sources.list.d/brave-browser-release.sources"
if [[ ! -f "$SOURCE_LIST" ]]; then
  echo "📄 Adding Brave APT source..."
  sudo curl -fsSLo "$SOURCE_LIST" https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
else
  echo "✅ Brave APT source already exists."
fi

echo "🔄 Updating package lists..."
sudo apt-get update -qq

echo "📦 Installing Brave Browser..."
sudo apt-get install -y -qq brave-browser

echo "🎉 Brave Browser installed successfully!"
