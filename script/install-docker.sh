#!/usr/bin/env bash
set -euo pipefail

# Update APT and install prerequisites
echo "🔄 Updating apt and installing dependencies..."
sudo apt-get update -qq
sudo apt-get install -y -qq ca-certificates curl gnupg lsb-release

# Create keyrings directory if it doesn't exist
KEYRING_DIR="/etc/apt/keyrings"
DOCKER_KEY="$KEYRING_DIR/docker.asc"

if [[ ! -d "$KEYRING_DIR" ]]; then
  echo "📁 Creating APT keyrings directory..."
  sudo install -m 0755 -d "$KEYRING_DIR"
fi

# Add Docker's official GPG key
if [[ ! -f "$DOCKER_KEY" ]]; then
  echo "🔐 Adding Docker GPG key..."
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o "$DOCKER_KEY"
  sudo chmod a+r "$DOCKER_KEY"
else
  echo "✅ Docker GPG key already exists."
fi

# Add Docker repository
REPO_FILE="/etc/apt/sources.list.d/docker.list"
CODENAME="$(. /etc/os-release && echo "$VERSION_CODENAME")"

if [[ ! -f "$REPO_FILE" ]]; then
  echo "📦 Adding Docker repository for $CODENAME..."
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEY] https://download.docker.com/linux/ubuntu $CODENAME stable" |
    sudo tee "$REPO_FILE" >/dev/null
else
  echo "✅ Docker APT repo already exists."
fi

# Install Docker packages
echo "⬇️ Installing Docker Engine and plugins..."
sudo apt-get update -qq
sudo apt-get install -y -qq \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# Post-install: Allow Docker usage without sudo
if ! getent group docker >/dev/null; then
  echo "👥 Creating 'docker' group..."
  sudo groupadd docker
else
  echo "✅ 'docker' group already exists."
fi

if id -nG "$USER" | grep -qw docker; then
  echo "✅ User '$USER' already in 'docker' group."
else
  echo "➕ Adding user '$USER' to 'docker' group..."
  sudo usermod -aG docker "$USER"
  newgrp docker
  echo "ℹ️  You may need to log out and log back in for this to take effect."
fi

# Test Docker installation
echo "🐳 Testing Docker..."
if docker run --rm hello-world >/dev/null 2>&1; then
  echo "✅ Docker is working without sudo!"
else
  echo "⚠️  Docker test failed. You might need to log out and log back in, or run 'newgrp docker'."
fi
