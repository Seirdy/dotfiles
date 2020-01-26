#!/usr/bin/env dash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
zsh -ic 'zinit module build'
