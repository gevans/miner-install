# miner-install

[![Build Status](https://travis-ci.org/postmodern/miner-install.png?branch=master)](https://travis-ci.org/gevans/miner-install)

Forked from [ruby-install](https://github.com/postmodern/ruby-install) and
adapted to work with CGMiner and its myriad of forks.

Currently supports installation of [CGMiner], [BFGMiner], or [SGMiner]

## Features

* Supports installing arbitrary versions.
* Supports installing into `/opt/miners/` for root and `~/.miners/` for users
  by default.
* Supports installing into arbitrary directories.
* Supports downloading from arbitrary URLs.
* Supports downloading from mirrors.
* Supports downloading/applying patches.
* Supports specifying arbitrary `./configure` options.
* Supports downloading archives using `wget` or `curl`.
* Supports verifying downloaded archives using `md5sum`, `md5` or `openssl md5`.
* Supports installing build dependencies via the package manager:
  * [apt]
  * [yum]
  * [pacman]
  * [macports]
  * [brew]
* Has tests.

## Anti-Features

* Does not require updating every time a new miner version comes out.
* Does not require recipes for each individual miner version or configuration.
* Does not support installing trunk/HEAD.

## Requirements

* [bash] >= 3.x
* [wget] or [curl]
* `md5sum`, `md5` or `openssl md5`.
* `tar`
* `patch` (if `--patch` is specified)
* [gcc] >= 4.2 or [clang]

## Synopsis

List supported Rubies and their major versions:

    $ miner-install

Install the current stable version of CGMiner:

    $ miner-install cgminer

Install a latest version of SGMiner:

    $ miner-install sgminer 4.1

Install a specific version of BFGMiner:

    $ miner-install bfgminer 3.10.0

Install a miner into a specific directory:

    $ miner-install -i /usr/local/ cgminer 3.7.2

Install a miner with a specific patch:

    $ miner-install -p https://raw.github.com/gist/4136373/falcon-gc.diff cgminer 4.1.0

Install a miner with a specific configuration:

    $ miner-install bfgminer -- --enable-shared --enable-dtrace CFLAGS="-O3"

## System-wide Install

    git clone https://github.com/gevans/miner-install.git
    cd miner-install
    sudo make install

[CGMiner]: https://github.com/ckolivas/cgminer
[SGMiner]: https://github.com/veox/sgminer
[BFGMiner]: https://github.com/luke-jr/bfgminer

[apt]: http://wiki.debian.org/Apt
[yum]: http://yum.baseurl.org/
[pacman]: https://wiki.archlinux.org/index.php/Pacman
[macports]: https://www.macports.org/
[brew]: http://brew.sh

[bash]: http://www.gnu.org/software/bash/
[wget]: http://www.gnu.org/software/wget/
[curl]: http://curl.haxx.se/

[gcc]: http://gcc.gnu.org/
[clang]: http://clang.llvm.org/

[PGP]: http://en.wikipedia.org/wiki/Pretty_Good_Privacy
[1]: http://postmodern.github.com/contact.html#pgp

[homebrew]: http://brew.sh/
