## Install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## check if the system in wsl2 or not
if grep -q "microsoft-standard" /proc/version; then
  echo "Running on WSL2"
else
  echo "Not running on WSL2"
  source ./install-vscode.sh
  source ./install-docker.sh
fi
