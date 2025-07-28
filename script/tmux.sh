# Check if Homebrew is installed
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Please install Homebrew first."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  error "git is required to install TPM. Please install git and try again."
  exit 1
fi

echo "Updating Homebrew..."
brew update

if brew list tmux >/dev/null 2>&1; then
  success "tmux is already installed"
else
  info "Installing tmux..."
  brew install tmux && success "tmux installed successfully"
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ -d "$TPM_DIR" ]; then
  success "TPM is already installed at $TPM_DIR"
else
  info "Cloning TPM into $TPM_DIR..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR" &&
    success "TPM installed successfully" ||
    error "Failed to clone TPM"
fi

