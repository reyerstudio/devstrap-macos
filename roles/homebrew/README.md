# Ansible Role: Homebrew

Configure [Homebrew][homebrew] packages, taps, and cask apps according to supplied variables.

## Role Variables

Available variables are listed below, along with default values (see [`defaults/main.yml`](defaults/main.yml)):

    homebrew_repo: https://github.com/Homebrew/brew

The GitHub repository for Homebrew core.

    homebrew_prefix: /usr/local
    homebrew_install_path: "{{ homebrew_prefix }}/Homebrew"

The path where Homebrew will be installed (`homebrew_prefix` is the parent directory). It is recommended you stick to the default, otherwise Homebrew might have some weird issues. If you change this variable, you should also manually create a symlink back to /usr/local so things work as Homebrew expects.

    homebrew_brew_bin_path: /usr/local/bin

The path where `brew` will be installed.

    homebrew_installed_packages:
      - ssh-copy-id
      - pv
      - { name: vim, install_options: "with-luajit,override-system-vi" }

Packages you would like to make sure are installed via `brew install`. You can optionally add flags to the install by setting an `install_options` property, and if used, you need to explicitly set the `name` for the package as well. By default, no packages are installed (`homebrew_installed_packages: []`).

    homebrew_uninstalled_packages: []

Packages you would like to make sure are _uninstalled_.

    homebrew_upgrade_all_packages: no

Whether to upgrade homebrew and all packages installed by homebrew. If you prefer to manually update packages via `brew` commands, leave this set to `no`.

    homebrew_taps:
      - homebrew/cask

Taps you would like to make sure Homebrew has tapped.

    homebrew_cask_apps:
      - firefox
      - { name: virtualbox, install_options:"debug,appdir=/Applications" }

Apps you would like to have installed via `cask`. [Search][caskroom] for popular apps to see if they're available for install via Cask. Cask will not be used if it is not included in the list of taps in the `homebrew_taps` variable. You can optionally add flags to the install by setting an `install_options` property, and if used, you need to explicitly set the `name` for the package as well. By default, no Cask apps will be installed (`homebrew_cask_apps: []`).

    homebrew_cask_accept_external_apps: true

Default value is `false` and would result in interruption of further processing of the whole role (and ansible play) in case any app given in `homebrew_cask_apps` is already installed without `cask`. Good for a tightly managed system.

Specify as `true` instead if you prefer to silently continue if any App is already installed without `cask`. Generally good for a system that is managed with `cask` / `Ansible` as well as other install methods (like manually) at the same time.

    homebrew_cask_uninstalled_apps:
      - google-chrome

Apps you would like to make sure are _uninstalled_.

    homebrew_cask_appdir: /Applications

Directory where applications installed via `cask` should be installed.

    homebrew_use_brewfile: true

Whether to install via a Brewfile. If so, you will need to install the `homebrew/bundle` tap, which could be done within `homebrew_taps`.

    homebrew_brewfile_dir: '~'

The directory where your Brewfile is located.

    homebrew_clear_cache: false

Set to `true` to remove the Hombrew cache after any new software is installed.

    homebrew_user: "{{ ansible_user_id }}"

The user that you would like to install Homebrew as.

    homebrew_group: "{{ ansible_user_gid }}"

The group that you would like to use while installing Homebrew.
