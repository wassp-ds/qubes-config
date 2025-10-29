{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - dev.install-common
  - dev.install-python-tools

"{{ slsdotpath }}-installed":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      - pre-commit

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
