include:
  - .clone

"tpl-{{ slsdotpath }}":
  qvm.vm:
    - require:
      - sls: {{ slsdotpath }}.clone
    - name: tpl-{{ slsdotpath }}
    - prefs:
      - memory: 300
      - maxmem: 400
    - features:
      - set:
        - default-menu-items: "qubes-run-terminal.desktop qubes-start.desktop"
        - menu-items: "qubes-run-terminal.desktop qubes-start.desktop"

"{{ slsdotpath }}":
  qvm.vm:
    - name: {{ slsdotpath }}
    - require:
      - sls: {{ slsdotpath }}.clone
    - present:
      - template: tpl-{{ slsdotpath }}
      - label: blue
    - prefs:
      - template: tpl-{{ slsdotpath }}
      - label: blue
      - netvm: ""
      - vpus: 1
      - memory: 400
      - maxmem: 500
      - autostart: False
      - include_in_backups: True
    - features:
      - set:
        - menu-items: "qubes-run-terminal.desktop qubes-start.desktop"
      - disable:
        - service.cups
        - service.cups-browsed

"{{ slsdotpath }}-minion":
  qvm.vm:
    - name: {{ slsdotpath }}-minion
    - require:
      - sls: {{ slsdotpath }}.clone
    - present:
      - template: tpl-{{ slsdotpath }}
      - label: blue
    - prefs:
      - template: tpl-{{ slsdotpath }}
      - label: blue
      - netvm: ""
      - vpus: 1
      - memory: 400
      - maxmem: 500
      - autostart: False
      - include_in_backups: True
    - features:
      - set:
        - menu-items: "qubes-run-terminal.desktop qubes-start.desktop"
      - disable:
        - service.cups
        - service.cups-browsed

{% from 'utils/macros/policy.sls' import policy_set with context -%}
{{ policy_set(sls_path, '80') }}
