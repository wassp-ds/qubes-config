{#
SPDX-FileCopyrightText: 2022 - 2023 unman <unman@thirdeyesecurity.org>
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: GPL-3.0-or-later
#}

{% if grains['nodename'] != 'dom0' -%}

include:
  - browser.install

"{{ slsdotpath }}-updated":
  pkg.uptodate:
    - refresh: True

"{{ slsdotpath }}-installed":
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - skip_suggestions: True
    - pkgs:
      - qubes-app-shutdown-idle
      - pulseaudio-qubes
      - vlc
      - audacious
      - calibre
      - gpicview
      - xpdf
      - ffmpeg
      - ffmpegthumbnailer
      - mousepad

"{{ slsdotpath }}-etc-mimeapps.list":
  file.managed:
    - name: /etc/xdg/mimeapps.list
    - source: salt://{{ slsdotpath }}/files/browser/mimeapps.list
    - mode: '0644'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-idle-trimleness":
  file.replace:
    - name: /usr/lib/python3/dist-packages/qubesidle/idleness_monitor.py
    - pattern: '15 \* 60'
    - repl: '3 * 60'

{% endif -%}
