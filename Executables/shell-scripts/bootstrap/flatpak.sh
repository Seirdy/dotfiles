#!/usr/bin/env dash

flatpak_remote_add() {
	flatpak remote-add --if-not-exists "$1" --from "$2" --user
}
flatpak_install() {
	flatpak install "$@" -y --user
}
flatpak_remote_add kdeapps https://distribute.kde.org/kdeapps.flatpakrepo
flatpak_remote_add gnome-nightly https://sdk.gnome.org/gnome-nightly.flatpakrepo
flatpak_remote_add gnome-apps-nightly https://sdk.gnome.org/gnome-apps-nightly.flatpakrepo
flatpak_remote_add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak_install flathub net.minetest.Minetest org.gtk.Gtk3theme.Breeze-Dark org.libreoffice.Libreoffice/x86_64 org.qbittorrent.qBittorrent org.zealdocs.Zeal website.i2pd.i2pd
flatpak_install flathub-beta net.supertuxkart.SuperTuxKart com.github.quaternion
flatpak_install gnome-apps-nightly org.Epiphpany.Devel
flatpak_install kdeapps org.kde.falkon org.kde.okular org.kde.konqueror org.kde.filelight
