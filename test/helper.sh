[[ -z "$SHUNIT2"     ]] && SHUNIT2=/usr/share/shunit2/shunit2
[[ -n "$ZSH_VERSION" ]] && setopt shwordsplit

. ./share/miner-install/miner-install.sh
. ./share/miner-install/functions.sh

export PATH="$PWD/bin:$PATH"

function setUp() { return; }
function tearDown() { return; }
function oneTimeTearDown() { return; }
