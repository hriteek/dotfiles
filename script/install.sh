## check if the system in wsl2 or not
## also need to check if this is sever or not (if server we don't want to install vscode cli)
if grep -q "microsoft-standard" /proc/version; then
  echo "Running on WSL2"
else
  echo "Not running on WSL2"
  source ./install-vscode.sh
  source ./install-docker.sh
fi
