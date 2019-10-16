#!/usr/bin/env dash

cargo install cargo cargo-update rls
cargo_install_git() {
	cargo install --git "$@" --force
}
cargo_install_git https://github.com/BurntSushi/ripgrep.git
cargo_install_git https://github.com/Peltoche/lsd.git
cargo_install_git https://github.com/anordal/shellharden.git
cargo_install_git https://github.com/dbrgn/tealdeer.git
cargo_install_git https://github.com/jameslzhu/roflcat.git
cargo_install_git https://github.com/Y2Z/monolith.git
cargo_install_git https://github.com/lunaryorn/mdcat.git
cargo_install_git https://github.com/o2sh/onefetch.git
cargo_install_git https://github.com/ogham/exa.git
cargo_install_git https://github.com/chmln/sd.git
cargo_install_git https://github.com/sharkdp/bat.git
cargo_install_git https://github.com/sharkdp/fd.git
cargo_install_git https://github.com/sharkdp/hyperfine.git
cargo_install_git https://github.com/timvisee/ffsend.git
cargo_install_git https://github.com/phiresky/ripgrep-all.git
cargo_install_git https://github.com/sharkdp/diskus.git
cargo_install_git https://github.com/greshake/i3status-rust.git
cargo_install_git https://github.com/Freaky/cw.git
