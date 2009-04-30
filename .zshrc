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
## Set aliases
#################
alias ls='ls --color=auto'

#################
## Load prompt theme
#################
setopt promptsubst
autoload -U promptinit
promptinit
prompt wunjo

