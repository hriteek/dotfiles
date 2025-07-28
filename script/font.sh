#!/usr/bin/env bash

set -euo pipefail

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

echo "Updating Homebrew..."
brew update

echo "Starting font installation..."

FONT_NAME="FiraCode"
FONT_VERSION="v3.2.1"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/$FONT_VERSION/${FONT_NAME}.zip"

# Determine font install path
if [[ "$OSTYPE" == "darwin"* ]]; then
  FONT_DIR="$HOME/Library/Fonts/$FONT_NAME"
else
  FONT_DIR="$HOME/.local/share/fonts/$FONT_NAME"
fi

# Install fontconfig if not present
if ! command -v fc-cache >/dev/null 2>&1; then
  echo "Installing fontconfig..."
  brew install fontconfig
fi

# Create a temp working dir
TMP_DIR=$(mktemp -d)

echo "📦 Downloading $FONT_NAME Nerd Font..."
curl -Ls -o "$TMP_DIR/${FONT_NAME}.zip" "$FONT_URL"

echo "📂 Unzipping font files..."
unzip -q "$TMP_DIR/${FONT_NAME}.zip" -d "$TMP_DIR/$FONT_NAME"

echo "📁 Installing to: $FONT_DIR"
mkdir -p "$FONT_DIR"
mv "$TMP_DIR/$FONT_NAME"/* "$FONT_DIR/"

echo "🔄 Updating font cache..."
fc-cache -fv "$FONT_DIR"

echo "🧹 Cleaning up..."
rm -rf "$TMP_DIR"

echo "✅ $FONT_NAME font installed successfully!"
