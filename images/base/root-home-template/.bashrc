#!/usr/bin/env bash

export CLICOLOR=1
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE="${HISTSIZE}"

export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

eval $(dircolors)
