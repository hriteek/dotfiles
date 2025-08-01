#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
  echo "❌ Please run with sudo: sudo $0"
  exit 1
fi

echo "🔧 Installing dependencies..."
apt update
apt install -y curl libfuse2t64 jq

echo "🔄 Fetching latest Cursor download info..."
API_URL="https://cursor.com/api/download?platform=linux-x64&releaseTrack=stable"
curl -s "$API_URL" -o /tmp/cursor.json

echo "📦 JSON response from API:"
cat /tmp/cursor.json
echo

APPIMAGE_URL=$(jq -r '.downloadUrl' /tmp/cursor.json)
VERSION=$(jq -r '.version' /tmp/cursor.json)

if [[ -z "$APPIMAGE_URL" || "$APPIMAGE_URL" == "null" ]]; then
  echo "❌ Failed to extract AppImage URL from API response."
  exit 1
fi

echo "✅ AppImage URL: $APPIMAGE_URL"
echo "✅ Version: $VERSION"

APPIMAGE_PATH="/opt/cursor-${VERSION}.AppImage"
ICON_PATH="/opt/cursor.png"
DESKTOP_PATH="/usr/share/applications/cursor.desktop"
ALIAS_NAME="cursor"

echo "📥 Downloading Cursor AppImage to $APPIMAGE_PATH..."
curl -L "$APPIMAGE_URL" -o "$APPIMAGE_PATH"
chmod +x "$APPIMAGE_PATH"

echo "🖼️ Downloading icon..."
curl -L "https://cursor.com/_next/static/media/placeholder-logo.da8a9d2b.webp" -o "$ICON_PATH" || echo "⚠️ Icon download failed"

echo "🖼️ Creating desktop launcher..."
cat >"$DESKTOP_PATH" <<EOF
[Desktop Entry]
Name=Cursor AI
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;
Terminal=false
EOF

chmod +x "$DESKTOP_PATH"

if [ -n "$SUDO_USER" ] && [ "$SUDO_USER" != "root" ]; then
  USER_HOME=$(eval echo "~$SUDO_USER")
  BASHRC_FILE="$USER_HOME/.bashrc"
  if ! grep -q "alias $ALIAS_NAME=" "$BASHRC_FILE"; then
    echo "alias $ALIAS_NAME='$APPIMAGE_PATH --no-sandbox'" >>"$BASHRC_FILE"
    echo "✅ Alias 'cursor' added to $BASHRC_FILE"
  fi
fi

echo ""
echo "🎉 Cursor v$VERSION installation complete!"
echo "📂 AppImage path: $APPIMAGE_PATH"
echo "🧠 Terminal command: cursor"
echo "🧭 Application menu: Cursor AI (log out/in if it doesn't appear)"
