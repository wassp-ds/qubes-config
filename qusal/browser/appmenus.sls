{#
SPDX-FileCopyrightText: 2023 Qusal contributors

SPDX-License-Identifier: GPL-3.0-or-later
#}

{% from 'utils/macros/sync-appmenus.sls' import sync_appmenus -%}
{{ sync_appmenus('tpl-' ~ sls_path) }}
