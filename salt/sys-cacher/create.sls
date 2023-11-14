{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- from "qvm/template.jinja" import load -%}

include:
  - .clone

{% load_yaml as defaults -%}
name: tpl-{{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
prefs:
- vcpus: 1
- memory: 300
- maxmem: 500
- autostart: False
- include_in_backups: False
features:
- disable:
  - service.cups
  - service.cups-browsed
  - service.tracker
  - service.evolution-data-server
- set:
  - menu-items: "cacher-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
  - default-menu-items: "cacher-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ slsdotpath }}
force: True
require:
- sls: {{ slsdotpath }}.clone
present:
- template: tpl-{{ slsdotpath }}
- label: gray
prefs:
- template: tpl-{{ slsdotpath }}
- label: gray
  ## Disable memory balooning because of HTTP 503: Cannot allocate memory
- maxmem: 0
- memory: 500
- vcpus: 1
- provides-network: true
- autostart: False
- include_in_backups: True
features:
- enable:
  - servicevm
- disable:
  - service.cups
  - service.cups-browsed
  - service.tinyproxy
  - service.meminfo-writer
- set:
  - menu-items: "cacher-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ slsdotpath }}-browser
force: true
require:
- sls: {{ slsdotpath }}.clone
present:
- template: tpl-browser
- label: gray
prefs:
- template: tpl-browser
- label: gray
- vcpus: 1
- netvm: ""
- memory: 300
- maxmem: 500
- autostart: False
- include_in_backups: False
features:
- disable:
  - service.cups
  - service.cups-browsed
  - service.tracker
  - service.evolution-data-server
- set:
  - menu-items: "cacher-browser.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% from 'utils/macros/policy.sls' import policy_set with context -%}
{{ policy_set(sls_path, '75') }}

"{{ slsdotpath }}-extend-volume":
  cmd.run:
    - name: qvm-volume extend {{ slsdotpath }}:private 20Gi
    - require:
      - qvm: {{ slsdotpath }}
