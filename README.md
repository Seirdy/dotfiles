Dotfiles
========

[![sourcehut](https://img.shields.io/badge/repository-sourcehut-lightgrey.svg?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEuMSINCiAgICB3aWR0aD0iMTI4IiBoZWlnaHQ9IjEyOCI+DQogIDxkZWZzPg0KICAgIDxmaWx0ZXIgaWQ9InNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSJibGFjayIgLz4NCiAgICA8L2ZpbHRlcj4NCiAgICA8ZmlsdGVyIGlkPSJ0ZXh0LXNoYWRvdyIgeD0iLTEwJSIgeT0iLTEwJSIgd2lkdGg9IjEyNSUiIGhlaWdodD0iMTI1JSI+DQogICAgICA8ZmVEcm9wU2hhZG93IGR4PSIwIiBkeT0iMCIgc3RkRGV2aWF0aW9uPSIxLjUiDQogICAgICAgIGZsb29kLWNvbG9yPSIjQUFBIiAvPg0KICAgIDwvZmlsdGVyPg0KICA8L2RlZnM+DQogIDxjaXJjbGUgY3g9IjUwJSIgY3k9IjUwJSIgcj0iMzglIiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjQlIg0KICAgIGZpbGw9Im5vbmUiIGZpbHRlcj0idXJsKCNzaGFkb3cpIiAvPg0KICA8Y2lyY2xlIGN4PSI1MCUiIGN5PSI1MCUiIHI9IjM4JSIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSI0JSINCiAgICBmaWxsPSJub25lIiBmaWx0ZXI9InVybCgjc2hhZG93KSIgLz4NCjwvc3ZnPg0KCg==)](https://git.sr.ht/~seirdy/dotfiles)
[![GitLab
mirror](https://img.shields.io/badge/mirror-GitLab-orange.svg?logo=gitlab)](https://gitlab.com/Seirdy/dotfiles)
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
[`update-all`](https://git.sr.ht/~seirdy/dotfiles/tree/master/.local/bin/update-all)
script runs [these
updates](https://git.sr.ht/~seirdy/dotfiles/tree/master/Executables/shell-scripts/updates).

C/C++ programs get compiled with the `-march=native` flags, among others. Most
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
- Terminal session manager: [tmux\*](https://tmux.github.io/)
- News reader: [Newsboat\*](https://newsboat.org/)
- Mail client: [aerc\*](https://aerc-mail.org/),
  [sendEmail](http://caspian.dotconf.net/menu/Software/SendEmail/)
- `$EDITOR`: Neovim\*
- Launcher: [custom](https://git.sr.ht/~seirdy/term-dmenu) (runs in a floating
  terminal window)
- File manager: [nnn\*](https://github.com/jarun/nnn)
- Image viewer: [imv\*](https://github.com/eXeC64/imv)
- IRC and Matrix: WeeChat\* and
  [weechat-matrix\*](https://github.com/poljar/weechat-matrix), respectively. I
  prefer IRC.
- Web browser: Firefox Nightly with
  [Tridactyl](https://github.com/tridactyl/tridactyl),
  [uMatrix](https://github.com/gorhill/uMatrix), uBlock Origin, and others to make
  browsing slightly more tolerable.

### Neovim

I use Neovim's built-in Language Server Protocol (LSP) client along with the official
[nvim-lsp](https://github.com/neovim/nvim-lsp) plugin containing pre-made configs for
popular language servers. Settings are split between an `init.vim` and Lua files.
Over time, I'll migrate more configs from Vim script to Lua.

### Shell

- shell (non-interactive): `dash*` for its ridiculously fast startup speed and
  minimal extensions over the POSIX spec.
- shell (interactive): [custom static build](https://git.sr.ht/~seirdy/zsh-bin) of
  `zsh*` inside `tmux*`. By using a static binary with full link-time optimization
  that only sources user config files, my shell initialization time for the
  interactive prompt was cut in half.
- plugin manager: [zinit\*](https://github.com/zdharma/zinit) loads plugins
  conditionally and asynchronously in the background to avoid slowing down startup
  time.
- prompt: [powerlevel10k\*](https://github.com/romkatv/powerlevel10k) with
  instant-prompt mode displays a cached prompt while the git status/return status are
  still loading.

### Music

I have an MPD-based music setup.

I've written several [scripts](https://git.sr.ht/~seirdy/mpd-scripts) to control MPD
and build playlists. My setup depends heavily upon rating tracks on a scale of 1-10
in the MPD sticker database.

- Backend: MPD
- Frontend: [clerk\*](https://github.com/carnager/clerk) +
  [ncmpcpp\*](https://github.com/arybczak/ncmpcpp)
- CLI control: [mpc\*](https://github.com/MusicPlayerDaemon/mpc) +
  [Playerctl\*](https://github.com/altdesktop/playerctl).
- Visualizer: [cava\*](https://github.com/karlstav/cava) and
  [projectM\*](https://github.com/projectM-visualizer/projectm)
- Playlist dynamizer:
  [cantata-dynamic\*](https://github.com/CDrummond/cantata/blob/master/playlists/cantata-dynamic)
  builds playlists up to a defined size according to rules. It automatically removes
  and adds tracks after they are played. I don't use cantata; I just use that Perl
  script.
- MPRIS 2 gateway and notification agent:
  [mpDris2](https://github.com/eonpatapon/mpDris2). Allows media keys to control mpd
  via Playerctl, and displays notifications.
- Album art viewer: [kunst\*](https://github.com/sdushantha/kunst). Works with imv.

### mpv

- Player: [mpv\*](https://mpv.io), built with VapourSynth support using
  [mpv-build](https://github.com/mpv-player/mpv-build). FFmpeg and libass are also
  built from master and statically linked with mpv.
- Upscaling filter: [Anime4k\*](https://github.com/bloc97/Anime4K) or
  [RAVU](https://github.com/bjin/mpv-prescalers), among
  [others](https://git.sr.ht/~seirdy/dotfiles/tree/master/.config/mpv/mpv.conf)
- MPRIS bridge: [mpv-mpris\*](https://github.com/hoyon/mpv-mpris)
- Other scripts:
  [blur-edges.lua](https://github.com/occivink/mpv-scripts/blob/master/scripts/blur-edges.lua),
  [autocrop.lua](https://github.com/mpv-player/mpv/TOOLS/lua/autocrop.lua)
  [autocrop.lua](https://github.com/mpv-player/mpv/TOOLS/lua/autocrop.lua)
