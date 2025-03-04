{#
SPDX-FileCopyrightText: 2024 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

{%- import slsdotpath ~ "/template.jinja" as template -%}

include:
  - .create

"{{ slsdotpath }}-set-management_dispvm-to-default":
  qvm.vm:
    - require:
      - cmd: "{{ slsdotpath }}-install-salt-deps"
      - sls: {{ slsdotpath }}.create
    - name: {{ template.template }}
    - prefs:
      - management_dispvm: "*default*"
