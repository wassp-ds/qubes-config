# dev

Development environment in Qubes OS.

## Table of Contents

*   [Description](#description)
*   [Installation](#installation)
*   [Access Control](#access-control)
*   [Usage](#usage)

## Description

Setup a development qube named "otee-dev", dedicated to contributing to OTee repositories.
As there is a very broad set of repositories, only common packages will be
installed. The qube has no netvm but can reach remote servers if the policy
allows.

## Installation

*   Top:

```sh
sudo qubesctl top.enable otee-dev
sudo qubesctl --targets=tpl-otee-dev,dvm-otee-dev,otee-dev state.apply
sudo qubesctl top.disable otee-dev
proxy_target="$(qusal-report-updatevm-origin)"
if test -n "${proxy_target}"; then
  sudo qubesctl --skip-dom0 --targets="${proxy_target}" state.apply sys-net.install-proxy
fi
```

*   State:

<!-- pkg:begin:post-install -->

```sh
sudo qubesctl state.apply otee-dev.create
sudo qubesctl --skip-dom0 --targets=tpl-otee-dev state.apply otee-dev.install
sudo qubesctl --skip-dom0 --targets=dvm-otee-dev state.apply otee-dev.configure-dvm
sudo qubesctl --skip-dom0 --targets=otee-dev state.apply otee-dev.configure
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

Allow qube `otee-dev` to `connect` to `github.com:22` via `disp-sys-net` but not to
any other host or via any other qube:

```qrexecpolicy
qusal.ConnectTCP +github.com+22 dev @default allow target=disp-sys-net
qusal.ConnectTCP *              dev @anyvm   deny
```

## Usage

The development qube `otee-dev` can be used for:

*   everything the [dev](../dev/README.md) qube can do;
*   contributing to OTee repositories

As the `otee-dev` qube has no netvm, configure the Qrexec policy to allow or ask
calls to the `qusal.ConnectTCP` RPC service, so the qube can communicate with
a remote repository for example.
