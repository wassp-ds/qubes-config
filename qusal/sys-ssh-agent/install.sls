{% if grains['nodename'] != 'dom0' -%}

include:
  - dotfiles.copy-x11
  - ssh.install

"{{ slsdotpath }}-updated":
  pkg.uptodate:
    - refresh: True

"{{ slsdotpath }}-installed":
  pkg.installed:
    - refresh: True
    - install_recommends: False
    - skip_suggestions: True
    - pkgs:
      - socat
      {% if grains['os_family']|lower == 'debian' -%}
      - libpam-systemd
      {% elif grains['os_family']|lower == 'redhat' -%}
      - systemd-pam
      {% endif -%}

"{{ slsdotpath }}-agent-bin-dir":
  file.recurse:
    - source: salt://{{ slsdotpath }}/files/agent/bin
    - name: /usr/bin
    - file_mode: '0755'
    - user: root
    - group: root

"{{ slsdotpath }}-agent-user-systemd-dir":
  file.recurse:
    - source: salt://{{ slsdotpath }}/files/agent/systemd/
    - name: /usr/lib/systemd/user/
    - dir_mode: '0755'
    - file_mode: '0644'
    - user: root
    - group: root

"{{ slsdotpath }}-agent-start-systemd-dbus-login-service":
  service.running:
    - name: dbus-org.freedesktop.login1.service

"{{ slsdotpath }}-agent-start-systemd-user-services-on-boot":
  cmd.run:
    - require:
      - service: "{{ slsdotpath }}-agent-start-systemd-dbus-login-service"
    - name: loginctl enable-linger user

"{{ slsdotpath }}-install-rpc-service":
  file.managed:
    - name: /etc/qubes-rpc/qusal.SshAgent
    - source: salt://{{ slsdotpath }}/files/rpc/qusal.SshAgent
    - mode: '0755'
    - user: root
    - group: root
    - makedirs: True

"{{ slsdotpath }}-skel-create-keys-directory":
  file.directory:
    - name: /etc/skel/keys
    - mode: '0700'
    - user: root
    - group: root

{% endif -%}
