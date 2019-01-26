# devstrap-macos
Automatic bootstrap macOS for development

## Prerequisite
- Create repository (for instance Gist) containing `devstrap.yml` file.
- Put extra files as `Brewfile` in this repository.
- GIT_URL is the URL of this repository.

### Examples
`devstrap.yml` 
``` yaml
---
- hosts: localhost
  vars:
    devstrap_base_path: ~/devstrap
  roles:
    - role: devstrap
      playbooks_repo: https://gist.github.com/xxxx.git
    - role: bash-it
    - role: dotfiles
      dotfiles_repo: https://github.com/xxxx/dotfiles.git
      dotfiles_files:
        - .bashrc
        - .bash_profile
        - .gitattributes
        - .gitconfig
        - .gitignore
        - .inputrc
        - .vimrc
    - role: homebrew
      homebrew_brewfile_dir: "~/devstrap/playbooks"
```

`Brewfile`
``` ruby
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"
tap "homebrew/services"
tap "homebrew/versions"
brew "a2ps"
brew "python"
brew "ansible"
brew "asciinema"
brew "autoconf"
brew "awscli"
brew "bash"
brew "bash-completion@2"
brew "p7zip"
brew "bison"
brew "chromedriver"
brew "cloc"
brew "colordiff"
brew "consul"
brew "coreutils"
brew "cowsay"
brew "dos2unix"
brew "gdrive"
brew "graphviz"
brew "highlight"
brew "hub"
brew "jq"
brew "kubernetes-cli"
brew "macvim"
brew "mas"
brew "md5sha1sum"
brew "ncdu"
brew "oath-toolkit"
brew "pandoc"
brew "tree"
brew "pass"
brew "terraform"
brew "tmux"
brew "unrar"
brew "vault"
brew "wakeonlan"
brew "watch"
brew "wget"
brew "wifi-password"
brew "youtube-dl"
brew "zlib"
cask "docker"
cask "font-hack"
cask "google-cloud-sdk"
cask "gpg-suite"
cask "iterm2"
cask "kdiff3"
cask "minikube"
cask "powershell"
cask "vagrant"
cask "virtualbox"
mas "Amphetamine", id: 937984704
mas "Xcode", id: 497799835
```

## Bootstrap
- Download `boostrap.sh` file
- Execute `bootstrap.sh GIT_URL` to bootstrap configuration and installation
- `/usr/local/bin/devstrap` helper is installed

## Playbook
- Execute `devstrap` to update configuration and installation
- Execute `devstrap <playbook name without extension>` to run playbook from GIT_URL
