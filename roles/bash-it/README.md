# Ansible Role: Bash-it

Ansible role to deploy [bash-it](https://github.com/Bash-it/bash-it) framework -
a collection of community Bash commands ands scripts.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    bash_it_repo: "https://github.com/foo/bash_it.git"
    bash_it_repo_version: master

The git repository and branch/tag/commit hash to use for retrieving Bash-it. Bash-it should generally be laid out within the root directory of the repository.

    bash_it_repo_accept_hostkey: false

Add the hostkey for the repo url if not already added. If ssh_opts contains "-o StrictHostKeyChecking=no", this parameter is ignored.

    bash_it_repo_local_destination: "~/Documents/bash-it"

The local path where the `bash_it_repo` will be cloned.

    aliases: []
    plugins: []
    completions: []
    
A list of aliases, plugins and completions to install.
