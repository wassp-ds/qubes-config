{% if grains['nodename'] != 'dom0' -%}

include:
  - dev.install-common

"{{ slsdotpath }}-installed-rust-deps":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs:
      - curl
      - build-essential
      - gcc

## Install rustup (Rust toolchain installer) via script
"{{ slsdotpath }}-download-rustup":
  cmd.run:
    - name: curl --proxy 127.0.0.1:8082 --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

## Add cargo bin to PATH
"{{ slsdotpath }}-cargo-path":
  file.append:
    - name: /home/{{ pillar.get('qusal:user', 'user') }}/.bashrc
    - text: 'export PATH="$HOME/.cargo/bin:$PATH"'
    - require:
      - cmd: "{{ slsdotpath }}-download-rustup"

## OS-specific packages for Rust development
{% set pkg = {
    'Debian': {
      'pkg': ['pkg-config', 'libssl-dev'],
    },
    'RedHat': {
      'pkg': ['pkgconf-pkg-config', 'openssl-devel'],
    },
}.get(grains.os_family) -%}

"{{ slsdotpath }}-installed-os-specific-rust":
  pkg.installed:
    - require:
      - sls: utils.tools.common.update
    - install_recommends: False
    - skip_suggestions: True
    - setopt: "install_weak_deps=False"
    - pkgs: {{ pkg.pkg|sequence|yaml }}

{% endif -%}
