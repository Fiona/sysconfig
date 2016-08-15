# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/fiona/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#################
## Key bindings
#################
# Home/end/delete fix
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '\e[3~' delete-char

#################
## Set aliases
#################
alias ls='ls --color=auto'
alias ack='ack-grep'
alias rmbadsteamlibs='find ~/.steam/root/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias rmbadsteamlibslocal='find ~/.local/share/Steam/ \( -name "libgcc_s.so*" -o -name "libstdc++.so*" -o -name "libxcb.so*" \) -print -delete'
alias steamfixdrierror='find ~/.steam/root/ -name "libgpg-error.so*" -print -delete'

#################
## Load prompt theme
#################
setopt promptsubst
autoload -U promptinit
promptinit
prompt wunjo

#################
## Random options
#################
# Ignore history duplicates
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Append and share history
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# ten second rm wait
setopt RM_STAR_WAIT

# auto cds if i type a directory name
setopt AUTO_CD

export WORKON_HOME=~/envs
source /usr/bin/virtualenvwrapper.sh

alias em='emacsclient -nc -a ""'
alias emc='emacsclient -t -a ""'
EDITOR='emacsclient -a ""'
export ALTERNATE_EDITOR=""


