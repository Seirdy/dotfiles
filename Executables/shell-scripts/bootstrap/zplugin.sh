#!/usr/bin/env dash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
zsh -ic "zplugin module build"
