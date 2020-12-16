#!/usr/bin/env dash

# shellcheck source=/home/rkumar/.config/shell_common/functions_ghq.sh
. "$HOME/.config/shell_common/functions_ghq.sh"
# shellcheck source=/home/rkumar/Executables/shell-scripts/updates/cc_funcs.sh
. "$HOME/Executables/shell-scripts/updates/cc_funcs.sh"
export CC=clang
export CXX=clang++
export CFLAGS="$CLANGFLAGS_UNUSED_STUFF"
export LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"

export RUSTFLAGS="$RUSTFLAGS \
	-L. \
	-C linker-plugin-lto \
	-C linker=clang \
	-C link-arg=-fuse-ld=lld \
	-C link-args=-s"

export RUSTFLAGS_STATIC_LTO="$RUSTFLAGS \
	-L. \
	-C linker-plugin-lto \
	-C linker=clang \
	-C link-arg=-fuse-ld=lld \
	-C target-feature=+crt-static \
	-C lto=fat"

echo "Using RUSTFLAGS: $RUSTFLAGS"
echo "Using CARGO_INSTALL_OPTS: $CARGO_INSTALL_OPTS"

export CC=clang
export CXX=clang++
export CFLAGS="$CLANGFLAGS"
export CXXFLAGS="$CLANGFLAGS"
rustup default nightly
rustup update
cargo install cargo-update
install_git() {
	cargo +nightly install --git "$@" --force -Z unstable-options
}
install_git_allfeat() {
	install_git "$@" --all-features
}
CARGO_INSTALL_OPTS="$CARGO_INSTALL_OPTS --target x86_64-unknown-linux-musl" RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" cargo install --git 'https://github.com/mbrubeck/agate.git' agate --target x86_64-unknown-linux-musl -Z unstable-options
CARGO_INSTALL_OPTS="$CARGO_INSTALL_OPTS --target x86_64-unknown-linux-musl" RUSTFLAGS="$RUSTFLAGS_STATIC_LTO" cargo install --git 'https://github.com/RazrFalcon/svgcleaner.git' svgcleaner --target x86_64-unknown-linux-musl -Z unstable-options
install_git_allfeat https://github.com/BurntSushi/ripgrep.git
install_git_allfeat https://github.com/Canop/broot.git
install_git_allfeat https://github.com/Freaky/cw.git
install_git_allfeat https://github.com/NerdyPepper/eva.git
install_git_allfeat https://github.com/Peltoche/lsd.git
install_git_allfeat https://github.com/Roger/tmux-hints.git
install_git_allfeat https://github.com/Y2Z/monolith.git
install_git_allfeat https://github.com/ajeetdsouza/zoxide.git
install_git_allfeat https://github.com/anordal/shellharden.git
install_git_allfeat https://github.com/chmln/sd.git
install_git_allfeat https://github.com/dandavison/delta.git
install_git_allfeat https://github.com/dbrgn/tealdeer.git
install_git_allfeat https://github.com/greshake/i3status-rust.git
install_git_allfeat https://github.com/jameslzhu/roflcat.git
install_git_allfeat https://github.com/lunaryorn/mdcat.git
install_git_allfeat https://github.com/o2sh/onefetch.git
install_git_allfeat https://github.com/ogham/exa.git
install_git_allfeat https://github.com/phiresky/ripgrep-all.git
install_git_allfeat https://github.com/sharkdp/bat.git
install_git_allfeat https://github.com/sharkdp/diskus.git
install_git_allfeat https://github.com/sharkdp/fd.git
install_git_allfeat https://github.com/sharkdp/hyperfine.git

install_git https://github.com/xiph/rav1e.git
install_git https://github.com/alacritty/alacritty.git --no-default-features --features "wayland" -Z unstable-options
install_git https://gitlab.com/timvisee/ffsend.git --features "archive history infer-command qrcode send2 send3 urlshorten" -Z unstable-options
