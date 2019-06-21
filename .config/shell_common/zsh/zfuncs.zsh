#!/bin/zsh

. ~/.config/shell_common/aliases.sh

# Opens a file in $EDITOR in kitty
# Like the "edi" alias but a pseudo-visual editor
function vdi() {
	kitty $EDITOR "$@" detch
}
