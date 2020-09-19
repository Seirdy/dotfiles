#!/usr/bin/env dash

set -e
# do a PGO build of foot (https://codeberg.org/dnkl/foot)
# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
export CFLAGS="$CFLAGS_LTO -fno-plt -Wno-missing-profile"
export LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"
ghq_get_cd "https://codeberg.org/dnkl/foot.git"
rm -rf subprojects
mkdir -p bld/release subprojects
cd subprojects
git clone https://codeberg.org/dnkl/tllist.git
git clone https://codeberg.org/dnkl/fcft.git
cd ..
meson --prefix "$PREFIX" --buildtype release -Db_lto=true bld/release
cd bld/release
meson configure -Db_pgo=generate
ninja
foot_tmp_file=$(mktemp)
./foot sh -c "../../scripts/generate-alt-random-writes.py --scroll --scroll-region --colors-regular --colors-bright --colors-rgb ${foot_tmp_file} && cat ${foot_tmp_file}"
rm "${foot_tmp_file}"
meson configure -Db_pgo=use -Db_lto=true
ninja
strip foot footclient
ninja install
