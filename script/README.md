## Install Script
A way to track list of applications and things that I install in my machine. And creating a script that helps to setup the new machine quickly just by running a single command


### Links
- [https://dev.to/devopsking/automation-with-bash-creating-a-script-to-install-and-configure-applications-on-multiple-flavours-of-os-4o0k](https://dev.to/devopsking/automation-with-bash-creating-a-script-to-install-and-configure-applications-on-multiple-flavours-of-os-4o0k)
- [https://github.com/basecamp/omakub/blob/master/install.sh](https://github.com/basecamp/omakub/blob/master/install.sh)
- [https://www.youtube.com/watch?v=FH083GOJoIM](https://www.youtube.com/watch?v=FH083GOJoIM)

### Things that are needed
- bat (alternative of cat) - done
- bun (can\'t we use corepack?)
- commitizen (git commit management) - done
- docker (need to check if this is wsl or linux)
- entr (file change watcher) - done
- eza (alternative of ls) - done
- fira code nerd font - added a command
- fontconfig - done (to configure font)
- fd (alternative of find) - done
- fnm (fast node manager) - done
- fzf - done
- gdu (disk usage analyzer: gdu-go) - done
- git - already done
- github cli - done
- homebrew - already done
- htop - done
- httpie - done
- jq - done
- nix and devbox - already done
- neovim - done
- ripgrep - done
- tldr - done
- tmux - done
- trash-cli - done
- vscode (need to check if wsl or linux)
- yq - done
- yazi (terminal file manager) - done
- zoxide (alternative of cd) - done

## Install TPM (tmux plugin manager)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install vscode cli
```bash
curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output vscode_cli.tar.gz

tar -xf vscode_cli.tar.gz

## create symlinks
sudo ln -s /home/hriteek/code /usr/local/bin/code

## run vscode tunnel
code tunnel
```

### How can I ensure I keep my tunnel running?
You have a few options:
- Use the service command to run as a service. You can run `code tunnel service install` and `code tunnel service uninstall` to install and remove them.
- Use the no-sleep option, code tunnel --no-sleep, to prevent your remote machine from going to sleep.