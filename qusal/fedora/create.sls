{#
SPDX-FileCopyrightText: 2023 Qusal contributors

SPDX-License-Identifier: GPL-3.0-or-later
#}

{%- import slsdotpath ~ "/template.jinja" as template -%}

include:
  - .clone

"dvm-{{ template.template }}-absent":
  qvm.absent:
    - names:
      - dvm-fedora
      - fedora-dvm
      - {{ template.template }}-dvm

{% load_yaml as defaults -%}
name: dvm-{{ template.template_clean }}
force: True
require:
- sls: {{ template.template_clean }}.clone
present:
- template: {{ fedora.fedora_template }}
- label: red
prefs:
- template: {{ fedora.fedora_template }}
- label: red
- memory: 300
- maxmem: 400
- vcpus: 1
- template_for_dispvms: True
- include_in_backups: False
features:
- enable:
  - appmenus-dispvm
- set:
  - menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}

{% load_yaml as defaults -%}
name: {{ template.template_clean }}
force: True
require:
- sls: {{ template.template_clean }}.clone
present:
- label: black
prefs:
- label: black
- memory: 300
- maxmem: 600
- vcpus: 1
- include_in_backups: False
features:
- set:
  - menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
  - default-menu-items: "qubes-open-file-manager.desktop qubes-run-terminal.desktop qubes-start.desktop"
{%- endload %}
{{ load(defaults) }}
