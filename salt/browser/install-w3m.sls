{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - {{ slsdotpath }}.install-common
  - dotfiles.copy-net

"{{ slsdotpath }}-installed-w3m":
  pkg.installed:
    - require:
      - sls: {{ slsdotpath }}.install-common
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      - w3m

{% endif -%}
