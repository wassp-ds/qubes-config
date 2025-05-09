{#
SPDX-FileCopyrightText: 2023 - 2025 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

include:
  - .create
  - mgmt.prefs

"{{ slsdotpath }}-set-tpl-{{ slsdotpath }}-management_dispvm-to-default":
  qvm.vm:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: tpl-{{ slsdotpath }}
    - prefs:
      - management_dispvm: "*default*"
