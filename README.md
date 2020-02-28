Dotfiles
========

[![sourcehut]](https://git.sr.ht/~seirdy/dotfiles)
[![GitLab](https://img.shields.io/badge/mirror-GitLab-orange.svg?logo=gitlab)](https://gitlab.com/Seirdy/dotfiles)
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

[sourcehut]: https://img.shields.io/badge/repository-sourcehut-lightgrey.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAMAAAD04JH5AAACPVBMVEUAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////9qcjBRAAAAvnRSTlMAAQIDBAUGBwgJCgsMDg8QERITFBUWFxgZGhscHR4fICEjJCYnKCkqKy0vMDM0NTY3ODk7PD1AQUNERkdISUtMTU5PUFFUV1hZWltcXV5fYGFkZmdoaW1ucHF0dXd4ent+f4CBgoOEhYaHiImKjZOUm5yeoaKjpKanqKmqq6ytsLGys7S2t7i6vL2+v8LDxMXGx8jJyszNzs/R0tPV1tjZ29/g4uPk5ebn6Orr7O3u7/Dx8vT19vf4+fr7/P3+A3PI6QAABcFJREFUGBntwflbVFUABuBvYtE0GWcgNUtCccncwzRU1KlwX3Mpc0vFBNtUzMowEFEJxRItAR0FN3AHNFBm5vvb+uWcO8u9M3PvnXN6np6H98WQIUOG/E/lf7hp/5Ha5tabHR03W5trj+zbON+P/8iw+Xvru2jh/uk9JbnQbMxn9S+YwvO6zQXQ5vV158NMK3xu9XDoUPTdM9r05NtCqPbeT2E6EDo+BSq9eyJCh8LVE6DKG1UDdKH/65FQ4pO7dOnOcmQu/1da6mo6un/bykBZWWDVtgNHL3TT0i9+ZGjxA5oMXqxYko8EBWUHm0M06SpFJrIOMVF/zYo8JOFdeWqACSIVWXDNd54J2rbkISXv1jYmOOuFSxNvMV7DAg/S8iw8y3jBIrgy8yHjNMyETbPPMU73DLhQ0sdYbQvhQOl1xuqZC8dKnjPGix3ZcCRn5z+M0TcPDs3sY4zmiXBs0p+M0fM+HJn4kFGRfVlwIbsiwqjuIjjgu8WoZ4vgUlkPo4Je2JZ1nlEdxXBtaiejGrJg1yFGXXsTGRjbxqgDsGkxo656kRHf3zRESmFLwQMarnmRIV87DV1+2PErDR1vImPjOmn4GTZ8SsOzYigwrZeGANJ64x6lyCIosYyGOyORThUN+6BIJQ2VSKPoJaXmLCiSfZnSQCFSO0HpxUQoU9xPqRopvRehtAMK7aIUnoJUfqLUlg2FcoKUqpFCUZjSQii1hFJoApL7jlID1PL8Tukwknr9GaWZUOwDSo+GIZl1lBqgXCOlFUjmPKUFUG4RpTNIYkyYQpsHynluUAj5Ye0zSlugwXZKG2GtnkJ/HjTwvaTwGywNe0GhBlrUUujLgZX5lFZAi7WU5sLKXgqDedDCF6awE1bqKVyEJi0UTsFKF4UKaFJF4TYs5FNaAk2WUcqD2YeU8qHJOEpzYLaJQhd08TyisAZm+yk0QZtLFHbD7AiFo9DmOIUfYFZLYT+0qaRwEmbNFLZBmy8oNMKslcJKaLOBQgvMblIIQJtyCu0w66BQBm0CFIIw66BQBm0CFIIwu0khAG3KKbTDrJXCKmizgUILzJopbIM2Oyg0wqyWwgFoU0XhJMyOUDgKbX6k8D3M9lG4AG0uUdgFs40UuqGL5zGF1TCbT6kAmrxFaTbM/JTKoMlySqNg4T6Fg9DkMIVOWDlNoRmaXKFQAyt7KIS80MIfofAlrJRQWgkt1lGaAyu5zymcghZ1FHqzYek0hQEvNPC/olADa5spbYUGn1NaD2sFYQptHijnCVIYHI0kzlFaCOUWU6pDMqspnYVyTZTKkczwJ5RmQ7ESSg9zkdS3lM5BLU8TpUokVxii9BGUWkppcDxSOE7peg4Uyr1F6RhSmRKmtBMK7aEUKkZK1ZT+mQRlJg9QOobUJvRT+iMbiuRcpdT/DtL4moYKKPINDQeRzsg7lCJlUOJjGm6PQFoBGnqmQoHpfTQshQ2/0NA5Fhl7+y4NJ2CHv4uGNh8ylH+DhnujYUtphIa/fMhIfisN4QWwqYJR7eOQgfE3GPUV7Mo6y6jOaXBt+l1GnX4NtnmDjOpdBpc+7mPU9VFwoOgBYxzKhgs53zDG/UI4MqOHMS4Xw7HJVxnj6XQ4NK+PMfp35cCR3D0DjNE7C47N62Gs4BLY51l6i7GezoILM7oZ5/cPYFNJE+Pcnw5XioKM17jIg7Q8i5sY73ohXPI2MMGN7T6k5P88yAT1o+BaVkWECV7WrvUhCf+6uldMEP7qNWSitIsm4ZaqZWMRz/PW8sNXIjS5twAZ8v9MS48uHa/8YkN5IFC+YUfVj5ce09KJ0chc4A5dur0USoysHKAL/QdHQJXC6jAdCh97BypNqQ7RgcFjxVBtwuFHtOlh5XjoMGzFmRDTGqwrz4U2/o2/9TGF3pr1o6FZztydp27TQmfNl3Oy8R/Jm7Nm9w8nG1vag8H2lsaT3+9aPXsUhgwZMuT/6V/RenbAjLiafgAAAABJRU5ErkJggg==
