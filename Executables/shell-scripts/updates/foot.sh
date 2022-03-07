#!/usr/bin/env dash

set -e
# do a PGO build of foot (https://codeberg.org/dnkl/foot)
# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
CFLAGS="-O3 -fstack-protector-strong -fcf-protection=full -fstack-clash-protection -fno-semantic-interposition -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fipa-pta -fdevirtualize-at-ltrans -DNDEBUG -march=native -g -pipe -Wformat -Werror=format-security -grecord-gcc-switches -m64 -fasynchronous-unwind-tables -s -fPIC -fPIE -fpic -fpie -Bsymbolic -ffunction-sections -fdata-sections -fgraphite-identity -mtls-dialect=gnu2 -malign-data=cacheline -fno-plt -fvisibility=hidden -L. -I$HOME/Executables/ghq/codeberg.org/dnkl/foot -flto -ffat-lto-objects -Wno-missing-profile"
export CFLAGS
export LDFLAGS="$CFLAGS -pie -Wl,-z,relro,-z,now,-z,noexecstack -Wl,--as-needed -Wl,-E -Wl,--gc-sections" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"
export CC=gcc CXX=g++ CCLD=ld.bfd
ghq_get_cd "https://codeberg.org/dnkl/foot.git"
# mkdir -p bld/release subprojects
# cd subprojects
# git -C ./tllist pull || git clone https://codeberg.org/dnkl/tllist.git
# git -C ./fcft pull || git clone https://codeberg.org/dnkl/fcft.git
# cd ..
meson --prefix "$PREFIX" --buildtype release -Db_lto=true -Dthemes=false -Ddocs=enabled -Dgrapheme-clustering=enabled -Dime=false -Dfcft:grapheme-shaping=enabled -Dfcft:run-shaping=enabled bld/release
cd bld/release
meson configure -Db_pgo=generate
# everything should be statically linked in except libffi, libwayland libs,
# libxkbcommon, and libfontconfig + their deps
ninja
foot_tmp_file="$(mktemp)"
python3 ../../scripts/generate-alt-random-writes.py --scroll --scroll-region --colors-regular --colors-bright --colors-256 --colors-rgb --attr-bold --attr-italic --attr-underline "$foot_tmp_file"
./footclient --version
./foot --override tweak.grapheme-shaping=no sh -c "cat $foot_tmp_file"
rm "$foot_tmp_file"
meson configure -Db_pgo=use -Db_lto=true -Dime=false -Dgrapheme-clustering=enabled -Dfcft:grapheme-shaping=enabled -Dfcft:run-shaping=enabled
ninja
strip foot footclient
ninja install
