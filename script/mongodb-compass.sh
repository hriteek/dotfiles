#!/bin/bash

# Check if version argument is provided
if [ -z "$1" ]; then
  echo "❌ Error: You must provide the MongoDB Compass version (e.g. 1.46.6)"
  echo "Usage: $0 <version>"
  exit 1
fi

VERSION="$1"
DEB_FILE="mongodb-compass_${VERSION}_amd64.deb"
DEB_URL="https://downloads.mongodb.com/compass/${DEB_FILE}"

# Function to compare versions
version_gt() {
  dpkg --compare-versions "$1" gt "$2"
}

version_eq() {
  dpkg --compare-versions "$1" eq "$2"
}

echo "🧪 Checking for existing MongoDB Compass installation..."

if command -v mongodb-compass &>/dev/null; then
  INSTALLED_VERSION=$(mongodb-compass --version | grep -oP '(\d+\.\d+\.\d+)' | head -n1)
  echo "✅ MongoDB Compass is already installed (version: $INSTALLED_VERSION)"
else
  INSTALLED_VERSION="0.0.0"
  echo "⚠️  MongoDB Compass is not currently installed"
fi

# Download the .deb file
echo "⬇️  Downloading MongoDB Compass version $VERSION..."
wget -q --show-progress "$DEB_URL" -O "$DEB_FILE"

if [ ! -f "$DEB_FILE" ]; then
  echo "❌ Failed to download the .deb file. Check if version $VERSION exists."
  exit 1
fi

# Compare versions and install if needed
if version_gt "$VERSION" "$INSTALLED_VERSION"; then
  echo "📦 Installing newer MongoDB Compass version $VERSION..."
  sudo apt install -y "./$DEB_FILE"
  echo "✅ Installation complete."
elif version_eq "$VERSION" "$INSTALLED_VERSION"; then
  echo "🟰 Version $VERSION is already installed. Skipping installation."
else
  echo "🆕 A newer version ($INSTALLED_VERSION) is already installed. Skipping installation."
fi

# Cleanup
echo "🧹 Cleaning up..."
rm -f "$DEB_FILE"
