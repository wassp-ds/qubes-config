{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - dev.install-common

"{{ slsdotpath }}-installed-qusal":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_recommends: True
    - sepopt: "install_weak_deps=False"
    - pkgs:
      - yamllint
      - codespell
      - pre-commit
      - reuse

## Debian doesn't have: salt-lint
