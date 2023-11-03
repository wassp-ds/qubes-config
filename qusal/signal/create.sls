{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: GPL-3.0-or-later
#}

{%- from "qvm/template.jinja" import load -%}

include:
  - .clone
  - .firewall

{% load_yaml as defaults -%}
name: tpl-{{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
features:
- set:
  - menu-items: "signal-desktop.desktop qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
  - default-menu-items: "signal-desktop.desktop qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
- qvm: tpl-{{ slsdotpath }}
present:
- template: tpl-{{ slsdotpath }}
- label: yellow
prefs:
- template: tpl-{{ slsdotpath }}
- label: yellow
- vpus: 1
- memory: 400
- maxmem: 600
- autostart: False
features:
- disable:
  - service.cups
  - service.cups-browsed
  - service.tinyproxy
  - service.tracker
  - service.evolution-data-server
- set:
  - menu-items: "signal-desktop.desktop qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% from 'utils/macros/sync-appmenus.sls' import sync_appmenus with context -%}
{{ sync_appmenus('tpl-' ~ sls_path) }}
