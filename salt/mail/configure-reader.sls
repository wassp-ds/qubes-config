{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' %}

include:
  - dotfiles.copy-x11
  - dotfiles.copy-sh
  - dotfiles.copy-net
  - dotfiles.copy-mutt

"{{ slsdotpath }}-reader-mailcap":
  file.managed:
    - name: /home/user/.mailcap
    - source: salt://{{ slsdotpath }}/files/reader/mailcap
    - mode: "0644"
    - user: user
    - group: user
    - makedirs: True

"{{ slsdotpath }}-reader-mutt-offline":
  file.symlink:
    - require:
      - pkg: dotfiles.copy-mutt
    - name: /home/user/.config/mutt/90_offline.muttrc
    - source: /home/user/.config/mutt/sample/offline.muttrc.example
    - force: True

{% endif -%}
