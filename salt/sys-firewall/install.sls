{#
SPDX-FileCopyrightText: 2023 - 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - utils.tools.common.update

"{{ slsdotpath }}-installed":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - pkgs:
      - fwupd-qubes-vm
      - qubes-core-agent-dom0-updates
      - qubes-core-agent-networking
      - ca-certificates
      - iproute2
      - systemd-timesyncd
      - man-db

{% endif -%}
