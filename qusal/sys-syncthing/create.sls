{#
SPDX-FileCopyrightText: 2022 unman <unman@thirdeyesecurity.com>
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: GPL-3.0-or-later
#}

{%- from "qvm/template.jinja" import load -%}

include:
  - .clone
  - browser.create

{% load_yaml as defaults -%}
name: tpl-{{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
prefs:
- vcpus: 1
- memory: 300
- maxmem: 700
- autostart: False
- include_in_backups: False
features:
- disable:
  - service.cups
  - service.cups-browsed
  - service.tracker
  - service.evolution-data-server
- set:
  - menu-items: "syncthing-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
  - default-menu-items: "syncthing-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
present:
- template: tpl-{{ slsdotpath }}
- label: yellow
prefs:
- template: tpl-{{ slsdotpath }}
- label: yellow
- vcpus: 1
- memory: 300
- maxmem: 700
- autostart: False
- include_in_backups: True
features:
- enable:
  - servicevm
- disable:
  - service.cups
  - service.cups-browsed
- set:
  - menu-items: "syncthing-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ slsdotpath }}-browser
force: True
require:
- sls: {{ slsdotpath }}.clone
present:
- template: tpl-browser
- label: yellow
prefs:
- template: tpl-browser
- label: yellow
- vcpus: 1
- netvm: ""
- memory: 300
- maxmem: 600
- autostart: False
- include_in_backups: False
features:
- disable:
  - service.cups
  - service.cups-browsed
  - service.tracker
  - service.evolution-data-server
- set:
  - menu-items: "syncthing-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

"{{ slsdotpath }}-resize-private-volume":
  cmd.run:
    - require:
      - qvm: {{ slsdotpath }}
    - name: qvm-volume extend {{ slsdotpath }}:private 50Gi

{% from 'utils/macros/policy.sls' import policy_set with context -%}
{{ policy_set(sls_path, '80') }}
