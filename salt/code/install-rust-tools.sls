{% if grains['nodename'] != 'dom0' -%}

include:
  - utils.tools.common.update

"{{ slsdotpath }}-installed-rust-tools":
  cmd.run:
  - require:
    - sls: utils.tools.common.update
  - name: 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh s -- -y'
  - unless: 'command -v rustup'

{% endif %}
