Dotfiles
========

It's my dotfiles! In this repository, you'll learn basically everything there is to
know about me.

These dotfiles are managed using [yadm](https://yadm.io) and are primarily intended
for Fedora. To install, simply clone the repo into `$HOME`.

For something that's been evolving since I was 14, it's surprisingly well-kept.

Bleeding edge
-------------

I like to be on the bleeding edge of programs I use often, but I'd like a stable OS
running underneath them. I worked out the following solution:

If I use a program that runs in the terminal very often, I'll likely build it from
source and update to the latest git commit. Git repositories get cloned using
[ghq](https://github.com/motemen/ghq). This way, if a program has a bug or is
missing a feature I want, I already have the latest snapshot of the repository
cloned locally on my machine so I can fix the issue and push a patch upstream. My
[`update-all`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/update-all)
script runs [these
updates](https://gitlab.com/Seirdy/dotfiles/tree/master/Executables/shell-scripts/updates).

C/C++ programs get compiled with the `-O3 -march=native` flags, among others.

I generally compile programs on my desktop and `rsync` them to my laptop.
Compilation occurs in a Fedora Rawhide pet container, created and managed using
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

-   WM: [Sway](https://swaywm.org/). SwayWM itself is from distro packages, but
    associated utilities are all built from source (e.g. swaybg, swayidle, grim,
    slurp)
-   Terminal emulator: [Alacritty\*](https://github.com/alacritty/alacritty)
    (Wayland) or [st\*](https://st.suckless.org/) (X11)
-   News reader: [Newsboat\*](https://newsboat.org/)
-   Mail client: [aerc\*](https://aerc-mail.org/)
-   `$EDITOR`: Neovim\*
-   Launcher:
    [custom](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/sway-launcher)
    (runs in a floating terminal window)
-   File manager: [nnn\*](https://github.com/jarun/nnn)
-   Image viewer: [imv\*](https://github.com/eXeC64/imv)
-   IRC and Matrix: `weechat` and
    [weechat-matrix\*](https://github.com/poljar/weechat-matrix), respectively.

### Shell

-   shell (non-interactive): `dash*`
-   shell (interactive): `zsh*` inside `tmux*`
-   plugin manager: [zplugin\*](https://github.com/zdharma/zplugin)
-   prompt: [powerlevel10k\*](https://github.com/romkatv/powerlevel10k)

### Music

The scripts
[`start-music`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/start-music)
and
[`stop-music`](https://gitlab.com/Seirdy/dotfiles/raw/master/.local/bin/stop-music)
are used to start/stop these programs, respectively.

-   Backend: `mpd`
-   Frontend: [clerk\*](https://github.com/carnager/clerk) +
    [ncmpcpp\*](https://github.com/arybczak/ncmpcpp)
-   CLI control: [mpc\*](https://github.com/MusicPlayerDaemon/mpc) +
    [Playerctl\*](https://github.com/altdesktop/playerctl).
-   Visualizer: [cava\*](https://github.com/karlstav/cava)
-   Playlist dynamizer:
    [cantata-dynamic\*](https://github.com/CDrummond/cantata/blob/master/playlists/cantata-dynamic)
    builds playlists up to a defined size according to rules. It automatically
    removes and adds tracks after they are played. I don't use cantata; I just use
    that Perl script.
-   MPRIS 2 gateway and notification agent:
    [mpDris2](https://github.com/eonpatapon/mpDris2). Allows media keys to control
    mpd via Playerctl, and displays notifications.
-   Album art viewer: [kunst\*](https://github.com/sdushantha/kunst). TODO: send a
    PR to get `kunst` to work with `imv`
