## check if curl is installed or not and install
if command -v curl >/dev/null; then
  echo "curl is installed"
else
  echo "curl is not installed. Installing curl..."
  sudo apt-get update
  sudo apt-get install -y curl
fi

## intall nix
curl -L https://nixos.org/nix/install | sh -s -- --daemon

## intall devbox
curl -fsSL https://get.jetify.com/devbox | bash

## install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install startship
curl -sS https://starship.rs/install.sh | sh