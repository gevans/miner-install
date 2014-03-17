# Contributing

## Code Style

* Indent code with 2 spaces.
* Keep code within 80 columns.
* Use [bash] 3.x features.
* Use the `function` keyword for functions.
* Quote all String variables.
* Prefer single-line expressions where appropriate:

  ```sh
  [[ -n "$foo" ]] && other command

  if   [[ "$foo" == "bar" ]]; then command
  elif [[ "$foo" == "baz" ]]; then other_command
  fi

  case "$foo" in
    bar) command ;;
    baz) other_command ;;
  esac
  ```

## Pull Request Guidelines

* Utility functions should go into `share/miner-install/miner-install.sh`.
* Generic installation steps should go into `share/miner-install/functions.sh`.
* Miner specific installation steps should go into
  `share/miner-install/$miner/functions.sh` and may override the generic steps
  in `share/miner-install/functions.sh`.
* Miner build dependencies should go into
  `share/miner-install/$miner/dependencies.txt`.
* Miner md5 checksums should go into `share/miner-install/$miner/md5.txt`.
* Miner version aliases should go into
  `share/miner-install/$miner/versions.txt`.
* All new code must have [shunit2] unit-tests.

### What Will Not Be Accepted

* Options for miner-specific `./configure` options. You can pass additional
  configuration options like so:

        miner-install sgminer 4.1.0 -- --foo --bar

* Excessive OS specific workarounds. We should strive to fix any miner build
  issues or OS environment issues.
* Building miners from HEAD. This is risky and may result in a buggy/broken
  version of a miner. The user should build development versions of miners by
  hand and report any bugs to upstream.

[Makefile]: https://gist.github.com/3224049
[shunit2]: http://code.google.com/p/shunit2/

[bash]: http://www.gnu.org/software/bash/
