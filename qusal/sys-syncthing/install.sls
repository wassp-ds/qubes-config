{#
SPDX-FileCopyrightText: 2022 - 2023 unman <unman@thirdeyesecurity.com>
SPDX-FileCopyrightText: 2023 Qusal contributors

SPDX-License-Identifier: GPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

{% from 'utils/macros/install-repo.sls' import install_repo -%}
{{ install_repo(sls_path, 'syncthing') }}

"{{ slsdotpath }}-updated":
  pkg.uptodate:
    - refresh: True

"{{ slsdotpath }}-installed":
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - skip_suggestions: True
    - pkgs:
      ## minimum
      - qubes-core-agent-networking
      - socat
      - syncthing
      {% if grains['os_family']|lower == 'debian' -%}
      - libpam-systemd
      {% elif grains['os_family']|lower == 'debian' -%}
      - systemd-pam
      {% endif -%}
      ## UI
      - firefox-esr
      - qubes-core-agent-nautilus
      - nautilus

"{{ slsdotpath }}-rpc-service":
  file.managed:
    - name: /etc/qubes-rpc/qusal.Syncthing
    - source: salt://{{ slsdotpath }}/files/rpc/qusal.Syncthing
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

"{{ slsdotpath }}-qubes-service":
  file.managed:
    - name: /lib/systemd/system/qubes-syncthing.service
    - source: salt://{{ slsdotpath }}/files/rpc/qubes-syncthing.service
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

"{{ slsdotpath }}-mask-syncthing":
  service.masked:
    - name: syncthing@user.service
    - runtime: False

"{{ slsdotpath }}-enable-qubes-syncthing":
  service.enabled:
    - name: qubes-syncthing.service

{% endif -%}
