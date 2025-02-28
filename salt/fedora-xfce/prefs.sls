{%- import slsdotpath ~ "/template.jinja" as template -%}

include:
  - .create

"{{ slsdotpath }}-set-{{ template.template }}-management_dispvm-to-default":
  qvm.vm:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: {{ template.template }}
    - prefs:
      - management_dispvm: "*default*"
