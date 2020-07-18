#!/usr/bin/env dash

flatpak_remote_add() {
	flatpak remote-add --if-not-exists "$1" --from "$2" --user
}
flatpak_install() {
	flatpak install "$@" -y --user
}

flatpak_remote_add kdeapps https://distribute.kde.org/kdeapps.flatpakrepo
flatpak_remote_add gnome-nightly https://sdk.gnome.org/gnome-nightly.flatpakrepo
flatpak_remote_add flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak_remote_add flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak_install flathub \
	'org.gtk.Gtk3theme.Breeze-Dark' \
	'app/org.libreoffice.LibreOffice' \
	'app/org.qbittorrent.qBittorrent' \
	'app/com.github.maoschanz.drawing' \
	'app/com.belmoussaoui.Obfuscate' \
	'app/com.github.tchx84.Flatseal' \
	'app/org.DolphinEmu.dolphin-emu' \
	'app/com.github.tchx84.Flatseal' \
	'app/net.supertuxkart.SuperTuxKart' \
	'com.viewizard.AstroMenace'

flatpak_install gnome-nightly \
	'app/org.gnome.Epiphpany.Devel' \
	'app/org.gnome.Maps'

flatpak_install kdeapps \
	'app/org.kde.falkon/x86_64'
