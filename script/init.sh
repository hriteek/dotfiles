#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check and install curl
if command_exists curl; then
  echo "curl is already installed."
else
  echo "curl is not installed. Installing curl..."
  sudo apt-get update
  sudo apt-get install -y curl
fi

# Check and install git
if command_exists git; then
  echo "git is already installed."
else
  echo "git is not installed. Installing git..."
  sudo apt-get update
  sudo apt-get install -y git
fi

# Check and install wl-clipboard
if command_exists wl-copy; then
  echo "wl-clipboard is already installed."
else
  echo "wl-clipboard is not installed. Installing wl-clipboard..."
  sudo apt-get update
  sudo apt-get install -y wl-clipboard
fi

# Check and install Nix
# if command_exists nix; then
#   echo "Nix is already installed."
# else
#   echo "Nix is not installed. Installing Nix..."
#   curl -L https://nixos.org/nix/install | sh -s -- --daemon
# fi

# Check and install Devbox
# if command_exists devbox; then
#   echo "Devbox is already installed."
# else
#   echo "Devbox is not installed. Installing Devbox..."
#   curl -fsSL https://get.jetify.com/devbox | bash
# fi

# Check and install Homebrew
if command_exists brew; then
  echo "Homebrew is already installed."
else
  echo "Homebrew is not installed. Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Check and install Starship prompt
if command_exists starship; then
  echo "Starship is already installed."
else
  echo "Starship is not installed. Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh
fi

echo "All installations and checks are complete."
