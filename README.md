## My dotfiles
using stow to manage dotfiles in the machine

## Requirement
Ensure you have the following installed on your system

### Git
```bash
  sudo apt update
  sudo apt install git
```


### Stow
```bash
  sudo apt install stow
```

## Installation
First, check out the dotfiles repo in you `$HOME` directory using git

```bash
  git clone https://github.com/hriteek/dotfiles.git
  cd dotfiles
```

then use GNU stow to create symlinks
```bash
  stow .
```

### Links
- [https://www.youtube.com/watch?v=WpQ5YiM7rD4](https://www.youtube.com/watch?v=WpQ5YiM7rD4)
- [https://www.youtube.com/watch?v=y6XCebnB9gs](https://www.youtube.com/watch?v=y6XCebnB9gs)
