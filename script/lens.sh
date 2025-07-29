#!/bin/bash

set -e

echo "🧹 Cleaning up any invalid Lens APT sources..."
sudo rm -f /etc/apt/sources.list.d/*lens*.list

echo "📥 Adding GPG key for Lens Desktop..."
curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg >/dev/null

echo "📝 Adding the correct Lens APT repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list >/dev/null

echo "🔄 Updating package list..."
sudo apt update

echo "📦 Installing Lens Desktop..."
sudo apt update && sudo apt install lens

echo "✅ Lens Desktop installation complete!"
