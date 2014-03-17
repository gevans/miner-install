if (( $UID == 0 )); then
  src_dir="${src_dir:-/usr/local/src}"
  miners_dir="${miners_dir:-/opt/miners}"
else
  src_dir="${src_dir:-$HOME/src}"
  miners_dir="${miners_dir:-$HOME/.miners}"
fi

install_dir="${install_dir:-$miners_dir/$miner-$miner_version}"

#
# Pre-install tasks
#
function pre_install()
{
  mkdir -p "$src_dir" || return $?
  mkdir -p "${install_dir%/*}" || return $?
}

#
# Install miner dependencies
#
function install_deps()
{
  local packages="$(fetch "$miner/dependencies" "$package_manager" || return $?)"

  if [[ -n "$packages" ]]; then
    log "Installing dependencies for $miner $miner_version ..."
    install_packages $packages || return $?
  fi

  install_optional_deps || return $?
}

#
# Install any optional dependencies.
#
function install_optional_deps() { return; }

#
# Download the miner archive
#
function download_miner()
{
  log "Downloading $miner_url into $src_dir ..."
  download "$miner_url" "$src_dir/$miner_archive" || return $?
}

#
# Verifies the miner archive matches a checksum.
#
function verify_miner()
{
  if [[ -n "$miner_md5" ]]; then
    log "Verifying $miner_archive ..."
    verify "$src_dir/$miner_archive" "$miner_md5" || return $?
  else
    warn "No checksum for $miner_archive. Proceeding anyway..."
  fi
}

#
# Extract the miner archive
#
function extract_miner()
{
  log "Extracting $miner_archive ..."
  extract "$src_dir/$miner_archive" "$src_dir" || return $?
}

#
# Initialize ADL SDK variables
#
function init_adl_sdk()
{
  if [ -z "$adl_sdk_version" ]; then
    adl_sdk_version="6.0"
    adl_sdk_md5="66c40ae8b98fd1ad057d2f1a7500d5cd"
  fi

  adl_sdk_archive="${adl_sdk_archive:-adl-sdk-$adl_sdk_version.tar.gz}"
  adl_sdk_src_dir="${adl_sdk_src_dir:-adl-sdk-$adl_sdk_version}"
  adl_sdk_mirror="${adl_sdk_mirror:-https://d2tncua5xjpuqz.cloudfront.net/adl-sdk}"
  adl_sdk_url="${adl_sdk_url:-$adl_sdk_mirror/$adl_sdk_archive}"
  miner_adl_sdk_dir="${miner_adl_sdk_dir:-$miner_src_dir/ADL_SDK}"
}

#
# Download the ADL SDK archive
#
function download_adl_sdk()
{
  log "Downloading ADL SDK $adl_sdk_version ..."
  download "$adl_sdk_url" "$src_dir/$adl_sdk_archive" || return $?
}

#
# Verify the ADL SDK archive
#
function verify_adl_sdk()
{
  if [[ -n "$adl_sdk_md5" ]]; then
    log "Verifying ADL SDK $adl_sdk_version ..."
    verify "$src_dir/$adl_sdk_archive" "$adl_sdk_md5" || return $?
  else
    warn "No checksum for $adl_sdk_archive. Proceeding anyway..."
  fi
}

#
# Extract the ADL SDK archive
#
function extract_adl_sdk()
{
  log "Extracting ADL SDK $adl_sdk_version ..."
  extract "$src_dir/$adl_sdk_archive" "$src_dir" || return $?
}

#
# Copy the ADL SDK headers into the miner's source directory
#
function copy_adl_sdk()
{
  log "Copying ADL SDK to $miner_adl_sdk_dir ..."
  mkdir -p "$src_dir/$miner_adl_sdk_dir" || return $?
  shopt -s nullglob
  cp -r "$src_dir/$adl_sdk_src_dir"/* "$src_dir/$miner_adl_sdk_dir/" || return $?
  shopt -u nullglob
}

#
# Install ADL SDK for OpenCL (GPU miners)
#
function install_adl_sdk()
{
  if [[ -z "$miner_install_adl_sdk" ]]; then
    miner_install_adl_sdk=true
  fi

  if [ "$miner_install_adl_sdk" = true ]; then
    init_adl_sdk
    log "Installing ADL SDK $adl_sdk_version ..."
    download_adl_sdk || return $?
    verify_adl_sdk   || return $?
    extract_adl_sdk  || return $?
    copy_adl_sdk     || return $?
  else
    log "Skipping install of ADL SDK."
    return
  fi
}

#
# Download any additional patches
#
function download_patches()
{
  local dest patch

  for (( i=0; i<${#patches[@]}; i++ )) do
    patch="${patches[$i]}"

    if [[ "$patch" == http:\/\/* || "$patch" == https:\/\/* ]]; then
      dest="$src_dir/$miner_src_dir/${patch##*/}"

      log "Downloading patch $patch ..."
      download "$patch" "$dest" || return $?
      patches[$i]="$dest"
    fi
  done
}

#
# Apply any additional patches
#
function apply_patches()
{
  local name

  for patch in "${patches[@]}"; do
    name="${patch##*/}"

    log "Applying patch $name ..."
    patch -p1 -d "$src_dir/$miner_src_dir" < "$patch" || return $?
  done
}

#
# Place holder function for configuring miner.
#
function configure_miner() { return; }

#
# Place holder function for cleaning miner.
#
function clean_miner() { return; }

#
# Place holder function for compiling miner.
#
function compile_miner() { return; }

#
# Place holder function for installing miner.
#
function install_miner() { return; }

#
# Place holder function for post-install tasks.
#
function post_install() { return; }
