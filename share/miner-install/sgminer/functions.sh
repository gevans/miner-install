#!/usr/bin/env bash

miner_archive="sgminer-$miner_version.tar.gz"
miner_src_dir="sgminer-$miner_version"
miner_mirror="${miner_mirror:-https://github.com/veox/sgminer/archive}"
miner_url="${miner_url:-$miner_mirror/$miner_version.tar.gz}"

#
# Configures sgminer
#
function configure_miner()
{
  log "Configuring sgminer $miner_version ..."
  libtoolize || return $?
  autoreconf -ivf || return $?
  ./configure --prefix="$install_dir" \
              "${configure_opts[@]}" || return $?
}

#
# Cleans sgminer
#
function clean_miner()
{
  log "Cleaning sgminer $miner_version ..."
  make clean || return $?
}

#
# Compiles sgminer
#
function compile_miner()
{
  log "Compiling sgminer $miner_version ..."
  make "${make_opts[@]}" || return $?
}

#
# Installs sgminer into $install_dir
#
function install_miner()
{
  log "Installing sgminer $miner_version ..."
  make install || return $?
}
