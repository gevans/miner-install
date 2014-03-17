# miner-install 1 "Mar 2014" miner-install "User Manuals"

## SYNOPSIS

`miner-install` [MINER [VERSION] [-- CONFIGURE_OPTS...]]

## DESCRIPTION

Installs CGMiner, SGMiner, or BFGMiner.

https://github.com/gevans/miner-install#readme

## ARGUMENTS

*MINER*
	Install miner by name.

*VERSION*
	Optionally select the version of selected miner.

*CONFIGURE_OPTS*
	Additional optional configure arguments.

## OPTIONS

`-s`, `--src-dir` *DIR*
	Specifies the directory for downloading and unpacking miner source.

`-r`, `--miners-dir` *DIR*
	Specifies the alternate directory where other miner directories are
	installed. Defaults to */opt/rubies* for root and *~/.miners* for
        normal users.

`-i`, `--install-dir` *DIR*
	Specifies the directory where miner will be installed.
	Defaults to */opt/miners/$miner-$version* for root and
	*~/.miners/$miner-$version* for normal users.

`-j[`*JOBS*`]`, `--jobs[=`*JOBS*`]`
	Specifies the number of *make* jobs to run in parallel when compiling
	miner. If the -j option is provided without an argument, *make* will
	allow an unlimited number of simultaneous jobs.

`-p`, `--patch` *FILE*
	Specifies any additional patches to apply.

`-M`, `--mirror` *URL*
	Specifies an alternate mirror to download the miner archive from.

`-u`, `--url` *URL*
	Alternate URL to download the miner archive from.

`-m`, `--md5` *MD5*
	Specifies the MD5 checksum for the miner archive.

`--no-download`
	Use the previously downloaded miner archive.

`--no-verify`
	Do not verify the downloaded miner archive.

`--no-install-deps`
	Do not install build dependencies before installing miner.

`--no-reinstall`
	Skip installation if another miner is detected in same location.

`-V`, `--version`
	Prints the current miner-install version.

`-h`, `--help`
	Prints a synopsis of miner-install usage.

## EXAMPLES

List supported miners and their major versions:

    $ miner-install

Install the current stable version of CGMiner:

    $ miner-install cgminer

Install a latest version of SGMiner:

    $ miner-install sgminer 4.1

Install a specific version of BFGMiner:

    $ miner-install bfgminer 3.10.0

Install a miner into a specific directory:

    $ miner-install -i /usr/local/ sgminer 4.1.0

Install a miner from a mirror:

    $ miner-install -M http://www.example.com/cudaminer cudaminer

Install a miner with a specific patch:

    $ miner-install -p https://raw.github.com/gist/4136373/falcon-gc.diff cgminer 3.7.2

Install a miner with specific configuration:

    $ miner-install cgminer 3.7.2 -- --enable-scrypt --enable-opencl

## FILES

*/usr/local/src*
	Default root user source directory.

*~/src*
	Default non-root user source directory.

*/opt/miners/$miner-$version*
	Default root user installation directory.

*~/.miners/$miner-$version*
	Default non-root user installation directory.

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>
Gabe Evans <gabe@ga.be>
