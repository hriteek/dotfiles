#!/bin/bash

set -e

# Constants
POSTMAN_URL="https://dl.pstmn.io/download/latest/linux64"
TMP_FILE="/tmp/postman.tar.gz"
INSTALL_DIR="/opt/Postman"
SYMLINK="/usr/local/bin/postman"
DESKTOP_FILE="$HOME/.local/share/applications/postman.desktop"

# Function: Get installed version
get_installed_version() {
  PACKAGE_JSON="$INSTALL_DIR/app/resources/app/package.json"
  if [ -f "$PACKAGE_JSON" ]; then
    grep '"version":' "$PACKAGE_JSON" | cut -d '"' -f 4
  else
    echo "none"
  fi
}

# Function: Get downloaded version
get_downloaded_version() {
  TEMP_EXTRACT_DIR=$(mktemp -d)
  tar -xzf "$TMP_FILE" -C "$TEMP_EXTRACT_DIR"
  PACKAGE_JSON="$TEMP_EXTRACT_DIR/Postman/app/resources/app/package.json"

  if [ ! -f "$PACKAGE_JSON" ]; then
    echo "❌ Could not find package.json in archive."
    rm -rf "$TEMP_EXTRACT_DIR"
    exit 1
  fi

  VERSION=$(grep '"version":' "$PACKAGE_JSON" | cut -d '"' -f 4)
  rm -rf "$TEMP_EXTRACT_DIR"
  echo "$VERSION"
}

# Step 1: Download tarball
echo "📦 Downloading latest Postman archive..."
wget -q --show-progress -O "$TMP_FILE" "$POSTMAN_URL"

# Step 2: Compare versions
echo "🔍 Checking installed version..."
INSTALLED_VERSION=$(get_installed_version)
echo "Installed version: $INSTALLED_VERSION"

echo "🔍 Checking downloaded version..."
DOWNLOADED_VERSION=$(get_downloaded_version)
echo "Downloaded version: $DOWNLOADED_VERSION"

if [ "$INSTALLED_VERSION" == "$DOWNLOADED_VERSION" ]; then
  echo "✅ You already have the latest version ($INSTALLED_VERSION). Skipping installation."
  rm "$TMP_FILE"
  exit 0
fi

# Step 3: Install or update
echo "🚀 Installing Postman $DOWNLOADED_VERSION..."
sudo rm -rf "$INSTALL_DIR"
sudo tar -xzf "$TMP_FILE" -C /opt
rm "$TMP_FILE"

# Step 4: Create symlink
if [ ! -L "$SYMLINK" ]; then
  echo "🔗 Creating symlink at $SYMLINK"
  sudo ln -s "$INSTALL_DIR/Postman" "$SYMLINK"
fi

# Step 5: Create desktop launcher
echo "📋 Creating desktop launcher..."
mkdir -p "$(dirname "$DESKTOP_FILE")"
ICON_PATH="$INSTALL_DIR/app/resources/app/assets/icon.png"

cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Postman
Exec=$SYMLINK
Icon=$ICON_PATH
Type=Application
Categories=Development;
Terminal=false
EOF

chmod +x "$DESKTOP_FILE"

echo "✅ Postman $DOWNLOADED_VERSION installed successfully."
