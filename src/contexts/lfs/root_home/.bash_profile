#!/usr/bin/env bash

export PS1='\u:\w\$ '

MAKEFLAGS="-j$(nproc --all)"

export MAKEFLAGS

alias ls='ls --color=auto --group-directories-first --human-readable --quoting-style=shell-escape'
