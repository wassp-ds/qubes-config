## TODO: should we allow minions to decide which states they should run?
{#
include:
{% if grains['id'] == 'dom0' -%}
  - .create
{% elif grains['id'] == 'tpl-' ~ slsdotpath -%}
  - .install
{% elif grains['id'] == 'disp-' ~ slsdotpath -%}
  - utils.tools.zsh.touch-zshrc
{% elif grains['id'] == slsdotpath -%}
  - .configure
{% endif -%}
#}
