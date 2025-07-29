#!/bin/bash

set -e

# --- Configuration ---
KANATA_PATH=$(which kanata)
KANATA_CONFIG="$HOME/.config/kanata/kanata.kbd"
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
SERVICE_FILE="$SYSTEMD_USER_DIR/kanata.service"
UINPUT_RULE="/etc/udev/rules.d/99-uinput.rules"

# --- Check prerequisites ---
if [ -z "$KANATA_PATH" ]; then
  echo "❌ Kanata is not found in your PATH. Please install it first."
  exit 1
fi

if [ ! -f "$KANATA_CONFIG" ]; then
  echo "❌ Kanata config file not found at $KANATA_CONFIG"
  echo "Make sure it exists before running this script."
  exit 1
fi

# --- Step 1: Setup uinput permissions ---
echo "🔧 Setting up /dev/uinput permissions..."

# Create udev rule for uinput
if [ ! -f "$UINPUT_RULE" ]; then
  echo "➡️  Creating udev rule at $UINPUT_RULE"
  sudo tee "$UINPUT_RULE" >/dev/null <<EOF
KERNEL=="uinput", GROUP="uinput", MODE="0660"
EOF
else
  echo "✅ Udev rule already exists: $UINPUT_RULE"
fi

# Create uinput group if it doesn't exist
if ! getent group uinput >/dev/null; then
  echo "➡️  Creating group: uinput"
  sudo groupadd uinput
else
  echo "✅ Group 'uinput' already exists"
fi

# Add user to uinput group
echo "➡️  Adding user '$USER' to group 'uinput'"
sudo usermod -aG uinput "$USER"

# Ensure uinput module is loaded now and at boot
echo "➡️  Enabling uinput kernel module..."
sudo modprobe uinput
echo uinput | sudo tee /etc/modules-load.d/uinput.conf >/dev/null

# Reload udev rules
echo "🔄 Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

# --- Step 2: Setup systemd user service ---
echo "🔧 Creating systemd user service..."

mkdir -p "$SYSTEMD_USER_DIR"

cat >"$SERVICE_FILE" <<EOF
[Unit]
Description=Kanata keyboard remapper
After=graphical.target

[Service]
ExecStart=$KANATA_PATH --cfg $KANATA_CONFIG
Restart=on-failure

[Install]
WantedBy=default.target
EOF

echo "✅ Kanata service created at $SERVICE_FILE"

# --- Enable lingering and systemd service ---
loginctl enable-linger "$USER"

systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user restart kanata.service

# --- Step 3: Show status and logs ---
echo ""
echo "📋 Kanata service status:"
echo "-------------------------"
systemctl --user status kanata.service --no-pager || true

echo ""
echo "📄 Recent logs (last 20 lines):"
echo "-------------------------------"
journalctl --user -u kanata.service --no-pager -n 20 || true

echo ""
echo "✅ All done. Please reboot your system for group membership to take effect."
