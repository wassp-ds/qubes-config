{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

include:
  - .create

"{{ slsdotpath }}-set-qubes-prefs-management_dispvm-to-dvm-{{ slsdotpath }}":
  cmd.run:
    - require:
      - cmd: "{{ slsdotpath }}-install-salt-deps"
      - sls: {{ slsdotpath }}.create
    - name: qubes-prefs -- management_dispvm dvm-{{ slsdotpath }}

"{{ slsdotpath }}-set-tpl-{{ slsdotpath }}-management_dispvm-to-default":
  qvm.vm:
    - require:
      - cmd: "{{ slsdotpath }}-install-salt-deps"
      - sls: {{ slsdotpath }}.create
    - name: tpl-{{ slsdotpath }}
    - prefs:
      - management_dispvm: "*default*"

"{{ slsdotpath }}-remove-default-mgmt-dvm":
  qvm.absent:
    - require:
      - cmd: "{{ slsdotpath }}-set-qubes-prefs-management_dispvm-to-dvm-{{ slsdotpath }}"
      - qvm: "{{ slsdotpath }}-set-tpl-{{ slsdotpath }}-management_dispvm-to-default"
    - name: default-mgmt-dvm
