{% if grains['nodename'] == 'dom0' -%}

{%- import slsdotpath ~ "/template.jinja" as template -%}

include:
  - .create

"{{ slsdotpath }}-update-admin":
  cmd.run:
    - require:
      - sls: {{ slsdotpath }}.create
    - name: qubes-vm-update --no-progress --show-output --targets={{ template.template }}

{% endif %}
