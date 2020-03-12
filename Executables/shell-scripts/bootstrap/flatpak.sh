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
flatpak_remote_add flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak_install flathub \
	'app/net.minetest.Minetest/x86_64' \
	'org.gtk.Gtk3theme.Breeze-Dark' \
	'app/org.libreoffice.LibreOffice/x86_64/stable' \
	'app/org.qbittorrent.qBittorrent' \
	'app/org.zealdocs.Zeal' \
	'app/website.i2pd.i2pd' \
	'app/org.signal.Signal'

flatpak_install flathub-beta \
	'app/net.supertuxkart.SuperTuxKart/x86_64/beta' \
	'app/com.github.quaternion/x86_64/beta' \
	'app/org.mozilla.firefox/x86_64/beta'

flatpak_install gnome-apps-nightly org.Epiphpany.Devel

flatpak_install kdeapps \
	'app/org.kde.falkon/x86_64'
