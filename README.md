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
      bash_it_aliases: []
      bash_it_plugins:
        - aws
        - base
        - fasd
        - fzf
      bash_it_completions:
        - awscli
        - minikube
        - pip3
        - ssh
        - terraform
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
    - role: vscode
      vscode_extensions:
        - DotJoshJohnson.xml
        - eamodio.gitlens
        - eg2.tslint
        - eriklynd.json-tools
        - HookyQR.beautify
        - mauve.terraform
        - ms-kubernetes-tools.vscode-kubernetes-tools
        - ms-python.python
        - ms-vscode.Go
        - msjsdiag.debugger-for-chrome
        - PeterJausovec.vscode-docker
        - PKief.material-icon-theme
        - quicktype.quicktype
        - rebornix.ruby
        - redhat.java
        - redhat.vscode-yaml
        - run-at-scale.terraform-doc-snippets
        - vscjava.vscode-java-debug
        - vscjava.vscode-java-dependency
        - vscjava.vscode-java-pack
        - vscjava.vscode-java-test
        - vscjava.vscode-maven
        - vscoss.vscode-ansible
      vscode_settings: {
        "editor.fontFamily": "Hack, monospace",
        "editor.fontSize": 16,
        "workbench.startupEditor": "newUntitledFile",
        "explorer.confirmDelete": false,
        "workbench.iconTheme": "material-icon-theme",
        "material-icon-theme.folders.theme": "specific",
        "workbench.colorCustomizations": {
            "list.focusBackground": "#0000AA"
        }
      }
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
cask "google-chrome"
cask "google-cloud-sdk"
cask "gpg-suite"
cask "iterm2"
cask "kdiff3"
cask "minikube"
cask "powershell"
cask "sourcetree"
cask "vagrant"
cask "virtualbox"
```

## Bootstrap
- Download `boostrap.sh` file
- Execute `bootstrap.sh GIT_URL` to bootstrap configuration and installation
- `/usr/local/bin/devstrap` helper is installed

## Playbook
- Execute `devstrap` to update configuration and installation
- Execute `devstrap <playbook name without extension>` to run playbook from GIT_URL
