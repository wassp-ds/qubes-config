{#
SPDX-FileCopyrightText: 2022 unman <unman@thirdeyesecurity.org>
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

include:
  - dev.home-cleanup

"{{ slsdotpath }}-rc.local":
  file.managed:
    - name: /rw/config/rc.local.d/50-sys-wireguard.rc
    - source: salt://{{ slsdotpath }}/files/server/rc.local.d/50-sys-wireguard.rc
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: True

"{{ slsdotpath }}-qubes-firewall":
  file.recurse:
    - name: /rw/config/qubes-firewall.d/
    - source: salt://{{ slsdotpath }}/files/server/qubes-firewall.d/
    - dir_mode: '0755'
    - file_mode: '0755'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-network-hooks":
  file.recurse:
    - name: /rw/config/network-hooks.d/
    - source: salt://{{ slsdotpath }}/files/server/network-hooks.d/
    - file_mode: '0755'
    - dir_mode: '0755'
    - user: root
    - group: root
    - makedirs: True
