# install app with brew
# brew install bat biome bun commitizen deno entr eza fd ffmpeg fzf fnm gdu gh helm htop lazygit jq kubectl neovim ripgrep tldr trash-cli unzip uv xh yq yazi zoxide

#!/usr/bin/env bash
# List of Homebrew packages to install
packages=(
  bat
  biome
  bun
  commitizen
  deno
  entr
  eza
  fd
  ffmpeg
  fzf
  fnm
  gdu
  gh
  helm
  htop
  lazygit
  jq
  kubectl
  neovim
  ripgrep
  tldr
  trash-cli
  unzip
  uv
  xh
  yq
  yazi
  zoxide
)

# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

echo "Updating Homebrew..."
brew update

echo "Starting package installation..."

for pkg in "${packages[@]}"; do
  if brew list "$pkg" >/dev/null 2>&1; then
    echo "✅ $pkg is already installed"
  else
    echo "📦 Installing $pkg..."
    if brew install "$pkg"; then
      echo "✅ Successfully installed $pkg"
    else
      echo "❌ Failed to install $pkg"
    fi
  fi
done

echo "🎉 All packages processed!"
