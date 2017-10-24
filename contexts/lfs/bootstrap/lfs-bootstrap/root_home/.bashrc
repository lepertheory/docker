set +o hashall

HOME=/root
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin
PS1='\u:\w\$ '

export HOME PATH

MAKEFLAGS="-j$(nproc --all)"

export MAKEFLAGS
