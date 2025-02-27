# code

Development environment in Qubes OS.

## Table of Contents

*   [Description](#description)
*   [Installation](#installation)
*   [Access Control](#access-control)
*   [Usage](#usage)

## Description

Setup a development qube named "dev". Defines the user interactive shell,
installing goodies, applying dotfiles, being client of sys-pgp, sys-git and
sys-ssh-agent. The qube has netvm but can reach remote servers if the policy
allows.

## Installation

*   Top:

```sh
sudo qubesctl top.enable code
sudo qubesctl --targets=tpl-code,dvm-code,code state.apply
sudo qubesctl top.disable code
proxy_target="$(qusal-report-updatevm-origin)"
if test -n "${proxy_target}"; then
  sudo qubesctl --skip-dom0 --targets="${proxy_target}" state.apply sys-net.install-proxy
fi
```

*   State:

<!-- pkg:begin:post-install -->

```sh
sudo qubesctl state.apply code.create
sudo qubesctl --skip-dom0 --targets=tpl-code state.apply code.install
sudo qubesctl --skip-dom0 --targets=dvm-code state.apply code.configure-dvm
sudo qubesctl --skip-dom0 --targets=code state.apply code.configure
proxy_target="$(qusal-report-updatevm-origin)"
if test -n "${proxy_target}"; then
  sudo qubesctl --skip-dom0 --targets="${proxy_target}" state.apply sys-net.install-proxy
fi
```

<!-- pkg:end:post-install -->


The installation will make the Qusal TCP Proxy available in the `updatevm`
(after it is restarted in case it is template based). If you want to have the
proxy available on a `netvm` that is not deployed by Qusal, install the Qusal
TCP proxy on the templates of your `netvm`:

```sh
sudo qubesctl --skip-dom0 --targets=TEMPLATE state.apply sys-net.install-proxy
```

Remember to restart the `netvms` after the proxy installation for the changes
to take effect.

## Access Control

_Default policy_: `denies` `all` qubes from calling `qusal.ConnectTCP`


## Usage

The development qube `code` can be used for:

*   code execution;
*   building programs;
*   fetching and pushing to and from local qube repository with split-git; and
