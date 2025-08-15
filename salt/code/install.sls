{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - utils.tools.common.update
  - dev.home-cleanup
  - dotfiles.copy-all
  - utils.tools.zsh
  - sys-pgp.install-client
  - sys-git.install-client
  - sys-ssh-agent.install-client

"{{ slsdotpath }}-installed":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      ## Necessary
      - qubes-core-agent-passwordless-root
      - ca-certificates
      ## Networking
      - qubes-core-agent-networking
      - curl
      ## Usability
      - tmux
      - xclip
      - bash-completion
      ## Reading documentation
      - man-db
      - info
      - texinfo
      - cloc
      ## Searching files
      - file
      - tree
      - ripgrep
      - fzf
      ## Lint
      - gitlint
      - pylint

## Fedora doesn't have: ruby-mdl (markdownlint, mdl)
## Debian doesn't have: salt-lint
{% set pkg = {
    'Debian': {
      'pkg': ['shellcheck', 'vim-nox', 'fd-find'],
    },
    'RedHat': {
      'pkg': ['ShellCheck', 'vim-enhanced', 'fd-find', 'salt-lint', 'passwd'],
    },
}.get(grains.os_family) -%}

"{{ slsdotpath }}-installed-os-specific":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs: {{ pkg.pkg|sequence|yaml }}

{% endif -%}
