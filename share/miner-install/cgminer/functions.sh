#!/usr/bin/env bash

miner_archive="cgminer-$miner_version.tar.gz"
miner_src_dir="cgminer-$miner_version"
miner_mirror="${miner_mirror:-https://github.com/ckolivas/cgminer/archive}"
miner_url="${miner_url:-$miner_mirror/v$miner_version.tar.gz}"

#
# Configures cgminer
#
function configure_miner()
{
  log "Configuring cgminer $miner_version ..."
  ./autogen.sh --prefix="$install_dir" --with-system-libusb \
               "${configure_opts[@]}" || return $?
}

#
# Cleans cgminer
#
function clean_miner()
{
  log "Cleaning cgminer $miner_version ..."
  make clean || return $?
}

#
# Compiles cgminer
#
function compile_miner()
{
  log "Compiling cgminer $miner_version ..."
  make "${make_opts[@]}" || return $?
}

#
# Installs cgminer into $install_dir
#
function install_miner()
{
  log "Installing cgminer $miner_version ..."
  make install || return $?
}
