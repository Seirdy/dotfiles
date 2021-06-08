#!/usr/bin/env dash

set -e
# do a PGO build of foot (https://codeberg.org/dnkl/foot)
# shellcheck source=/home/rkumar/startup.sh
# shellcheck source=../../../.config/shell_common/functions_ghq.sh
. "$XDG_CONFIG_HOME/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
CFLAGS="-O3 -DNDEBUG -mcpu=native -mtune=native -march=native -g -pipe -Wformat -Werror=format-security -grecord-gcc-switches -m64 -fasynchronous-unwind-tables -s -fPIC -fPIE -fuse-ld=lld -L. -flto -ffat-lto-objects $(pkg-config --cflags --libs --static xkbcommon pixman-1 libbrotlicommon libbrotlidec) -Wno-missing-profile"
export CFLAGS
export LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"
ghq_get_cd "https://codeberg.org/dnkl/foot.git"
mkdir -p bld/release subprojects
cd subprojects
git -C ./tllist pull || git clone https://codeberg.org/dnkl/tllist.git
git -C ./fcft pull || git clone https://codeberg.org/dnkl/fcft.git
cd ..
meson --prefix "$PREFIX" --buildtype release -Db_lto=true -Dime=false -Dfcft:text-shaping=disabled bld/release
cd bld/release
meson configure -Db_pgo=generate
# everything should be statically linked in except libffi, libwayland libs,
# libxkbcommon, and libfontconfig + their deps
ninja
foot_tmp_file=$(mktemp)
python3 ../../scripts/generate-alt-random-writes.py --scroll --scroll-region --colors-regular --colors-bright --colors-256 --colors-rgb --attr-bold --attr-italic --attr-underline ${foot_tmp_file}
./foot sh -c "cxxmatrix -s rain --frame-rate 120 --diffuse && cat ${foot_tmp_file}"
rm "${foot_tmp_file}"
meson configure -Db_pgo=use -Db_lto=true -Dime=false -Dfcft:text-shaping=disabled
ninja
strip foot footclient
ninja install
