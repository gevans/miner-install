#!/usr/bin/env bash
# FIXME: GitHub tarballs don't include bfgminer's submodules. x.x

miner_src_dir="bfgminer-$miner_version"
miner_mirror="${miner_mirror:-https://github.com}"
miner_url="${miner_url:-$miner_mirror/luke-jr/bfgminer.git}"
miner_install_adl_sdk=false

#
# Clones bfgminer into $src_dir
#
function download_miner()
{
  if [ ! -d "$src_dir/$miner_src_dir/.git" ]; then
    log "Cloning $miner_url ..."
    git clone "$miner_url" "$src_dir/$miner_src_dir" || return $?
  fi

  cd "$src_dir/$miner_src_dir"
  git checkout "bfgminer-$miner_version" || return $?
}

#
# Prevents the default extract task from executing
#
function extract_miner()
{
  return
}

#
# Configures bfgminer
#
function configure_miner()
{
  log "Configuring bfgminer $miner_version ..."
  ./autogen.sh || return $?
  ./configure --prefix="$install_dir" --enable-scrypt \
              --with-udevrulesdir="$install_dir/lib/udev/rules.d" \
              "${configure_opts[@]}" || return $?
}

#
# Cleans bfgminer
#
function clean_miner()
{
  log "Cleaning bfgminer $miner_version ..."
  make clean || return $?
}

#
# Compiles bfgminer 
#
function compile_miner()
{
  log "Compiling bfgminer $miner_version ..."
  make "${make_opts[@]}" || return $?
}

#
# Installs bfgminer into $install_dir
#
function install_miner()
{
  log "Installing bfgminer $miner_version ..."
  make install || return $?
}

#
# Prints install notes
#
function post_install()
{
  warn "
You may want to symlink files in $install_dir/lib/udev/rules.d/
to /lib/udev/rules.d/:

    sudo ln -s $install_dir/lib/udev/rules.d/* /lib/udev/rules.d/
"
}
