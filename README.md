Dotfiles
========

[![GitLab](https://img.shields.io/badge/repository-GitLab-orange.svg?logo=gitlab)](https://gitlab.com/Seirdy/dotfiles)
[![GitHub
mirror](https://img.shields.io/badge/mirror-GitHub-black.svg?logo=github)](https://github.com/Seirdy/dotfiles)

It's my dotfiles! This is me.

These dotfiles are managed using [yadm](https://yadm.io) and are primarily intended
for Fedora. To install, simply clone the repo into `$HOME` and run the bootstrap
scripts in `Executables/shell-scripts/bootstrap`. The scripts for building packages
might max out your CPU all night, so be prepared.

This has been evolving since I was 14, yet nothing here lives that long before being
rewritten.

My scripts generally have the `#!/usr/bin/env dash` shebang, but the syntax is all
POSIX sh compatible.

![screenshot of awesomeness](https://i.imgur.com/IHidSxb.png)

Bleeding edge
-------------

I like to be on the bleeding edge of programs I use often, but I'd like a stable OS
running underneath them. I worked out the following solution:

If I use a program that runs in the terminal very often, I'll likely build it from
source and update to the latest git commit. Git repositories get cloned using
[ghq](https://github.com/motemen/ghq). This way, if a program has a bug or is missing
a feature I want, I already have the latest snapshot of the repository cloned locally
on my machine so I can fix the issue and push a patch upstream. My
[`update-all`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/update-all)
script runs [these
updates](https://gitlab.com/Seirdy/dotfiles/tree/master/Executables/shell-scripts/updates).

C/C++ programs get compiled with the `-O3 -march=native` flags, among others. Most
packages are also compiled using link-time optimization. Rust packages containing
C/C++ code use LLVM instead of GCC. When possible, Rust packages are compiled to
statically-linked executables with full link-time optimization in an Alpine-based
container.

I generally compile programs on my desktop and `rsync` them to my laptop. Compilation
occurs in a Fedora Rawhide pet container, created and managed using
[podman](https://podman.io/) and [toolbox](https://github.com/containers/toolbox).
`rsync` along with the full container stack (podman, buildah, skopeo, crun,
fuse-overlayfs, fusermount, conmon, bubblewrap, catatonit) are also built from
master, of course.

Mah stuff
---------

Pretty much all my programs run in the terminal, with obvious exceptions (most
notably my web browser, image viewer (imv), and media player (mpv)).

Stuff labeled with `*` is built from source from the latest git commit.

### General

- WM: [Sway\*](https://swaywm.org/). Associated utilities are also built from source
  (e.g. swaybg\*, swayidle\*, grim\*, and slurp\*)
- Terminal emulator: [Alacritty\*](https://github.com/alacritty/alacritty) (Wayland)
  or [st\*](https://st.suckless.org/) (X11)
- Terminal multiplexer/session manager: [tmux\*](https://tmux.github.io/)
- News reader: [Newsboat\*](https://newsboat.org/)
- Mail client: [aerc\*](https://aerc-mail.org/)
- `$EDITOR`: Neovim\*
- Launcher: [custom](https://gitlab.com/Seirdy/term-dmenu) (runs in a floating
  terminal window)
- File manager: [nnn\*](https://github.com/jarun/nnn)
- Image viewer: [imv\*](https://github.com/eXeC64/imv)
- IRC and Matrix: `weechat*` and
  [weechat-matrix\*](https://github.com/poljar/weechat-matrix), respectively. I
  prefer IRC.

### Neovim

I use Neovim's built-in Language Server Protocol (LSP) client along with the official
[nvim-lsp](github.com/neovim/nvim-lsp) plugin containing pre-made configs for popular
language servers. Settings are split between an `init.vim` and `init.lua`. Over time,
I'll migrate more configs from `init.vim` to Lua files.

### Shell

- shell (non-interactive): `dash*`
- shell (interactive): `zsh*` inside `tmux*`
- plugin manager: [zinit\*](https://github.com/zdharma/zinit)
- prompt: [powerlevel10k\*](https://github.com/romkatv/powerlevel10k)

### Music

The scripts
[`start-music`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/start-music)
and
[`stop-music`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/stop-music)
are used to start/stop these programs, respectively.

- Backend: `mpd`
- Frontend: [clerk\*](https://github.com/carnager/clerk) +
  [ncmpcpp\*](https://github.com/arybczak/ncmpcpp)
- CLI control: [mpc\*](https://github.com/MusicPlayerDaemon/mpc) +
  [Playerctl\*](https://github.com/altdesktop/playerctl).
- Visualizer: [cava\*](https://github.com/karlstav/cava)
- Playlist dynamizer:
  [cantata-dynamic\*](https://github.com/CDrummond/cantata/blob/master/playlists/cantata-dynamic)
  builds playlists up to a defined size according to rules. It automatically removes
  and adds tracks after they are played. I don't use cantata; I just use that Perl
  script.
- MPRIS 2 gateway and notification agent:
  [mpDris2](https://github.com/eonpatapon/mpDris2). Allows media keys to control mpd
  via Playerctl, and displays notifications.
- Album art viewer: [kunst\*](https://github.com/sdushantha/kunst). TODO: send a PR
  to get `kunst` to work with `imv`

### mpv

- Player: [mpv\*](https://mpv.io), built with Vapoursynth support
- Upscaling filter: [Anime4k\*](https://github.com/bloc97/Anime4K)
- MPRIS bridge: [mpv-mpris\*](https://github.com/hoyon/mpv-mpris)
- Other scripts:
  [blur-edges.lua](github.com/occivink/mpv-scripts/blob/master/scripts/blur-edges.lua),
  [autocrop.lua](github.com/mpv-player/mpv/TOOLS/lua/autocrop.lua)
