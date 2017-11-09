#!/usr/bin/env bash

PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin
PS1='\u:\w\$ '

export PATH PS1

MAKEFLAGS="-j$(nproc --all)"

export MAKEFLAGS
