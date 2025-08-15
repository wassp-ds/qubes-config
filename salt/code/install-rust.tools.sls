{% if grains['nodename'] != 'dom0' -%}

include:
  - utils.tools.common.update

"{{ slsdotpath }}-installed-rust-tools":
  cmd.run:
    - name: 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.sh | sh s -- -y'
    - unless: 'command -v rustup'
    - require:
      - pkg: curl
      - pkg: ca-certificates

{% endif %}
