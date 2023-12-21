{#
SPDX-FileCopyrightText: 2023 Benjamin Grande M. S. <ben.grande.b@gmail.com>

SPDX-License-Identifier: AGPL-3.0-or-later
#}

include:
  - .create

"{{ slsdotpath }}-qubes-prefs-updatevm":
  cmd.run:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: qubes-prefs updatevm {{ slsdotpath }}

"{{ slsdotpath }}-qubes-prefs-default_netvm":
  cmd.run:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: qubes-prefs default_netvm {{ slsdotpath }}

"{{ slsdotpath }}-qubes-prefs-clockvm":
  cmd.run:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: qubes-prefs clockvm {{ slsdotpath }}
