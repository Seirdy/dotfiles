#!/bin/zsh
autoload -Uz add-zsh-hook
# use transient prompt. Set it to "off" since I don't want
# to use its default elements; I want to use the same elements as line 2
export POWERLEVEL9K_TRANSIENT_PROMPT=off
# export POWERLEVEL9K_GITSTATUS_DIR="$GHQ_ROOT/github.com/romkatv/gitstatus"
POWERLEVEL9K_DEFAULT_BACKGROUND='black'
# add invisible execution time to left prompt
# in order to show it in the right-side transient prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	dir_writable dir virtualenv vcs newline vi_mode status
)
export POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true
function p10k-on-pre-prompt() { p10k display '1'=show}
function p10k-on-post-prompt() {
  [[ $last_prompt_dir == $PWD ]] && p10k display '1'=hide
  last_prompt_dir=$PWD
}
# fi
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
	root_indicator background_jobs command_execution_time time
)

# my tmux config should display the hostname. if we're not in tmux, it's redundant
if [ -n "$SSH_CONNECTION" ] || hostname | grep -q 'toolbox'; then
	[ -n "$TMUX" ] || POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host $POWERLEVEL9K_LEFT_PROMPT_ELEMENTS)
fi
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_MODE="awesome-fontconfig"
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
# right prompt colors
POWERLEVEL9K_HOST_FOREGROUND=12
POWERLEVEL9K_TIME_BACKGROUND='blue'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=12 # light blue
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0.5
POWERLEVEL9K_HISTORY_BACKGROUND='cyan'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='black' # light cyan

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='cyan'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=12
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=12

POWERLEVEL9K_STATUS_OK_FOREGROUND='cyan'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=09
# powerlevel9k icons
POWERLEVEL9K_SHORTEN_DELIMITER=''
POWERLEVEL9K_HOME_ICON=$'\uf7db'     # 
POWERLEVEL9K_HOME_SUB_ICON=$'\uf74a' # 
POWERLEVEL9K_FOLDER_ICON=$'\uf74f'   #  ﱮ
POWERLEVEL9K_VI_INSERT_MODE_STRING=$'\uf8ea'
POWERLEVEL9K_VI_COMMAND_MODE_STRING=$'\uf8ee'
# VCS icons
POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d2 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113 '
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue725 '
POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421'
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
POWERLEVEL9K_VCS_STASH_ICON=$'\uf140 '
POWERLEVEL9K_VCS_MODIFIED_ICON=$'\uf192'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '
POWERLEVEL9K_SHOW_CHANGESET="true"
POWERLEVEL9K_CHANGESET_HASH_LENGTH="8"
# anaconda
POWERLEVEL9K_ANACONDA_BACKGROUND='cyan'
POWERLEVEL9K_ANACONDA_LEFT_DELIMITER=''
POWERLEVEL9K_ANACONDA_RIGHT_DELIMITER=''
# powerlevel9k status icons
POWERLEVEL9K_OK_ICON=$'\uf054'

# Remove some icons
POWERLEVEL9K_TIME_ICON=
POWERLEVEL9K_EXECUTION_TIME_ICON=
