#!/usr/bin/env sed --quiet --regexp-extended --unbuffered

\%^/mnt/lfs/sources/binutils-2\.29/(zlib|binutils|gas|gprof|ld|bfd|opcodes)/configure: line [0-9]+: /usr/bin/file: No such file or directory$:q
%w /home/lfs/
#ar: `u' modifier ignored since `D' is the default \(see `U'\)
#In file included from \.\./\.\./bfd/elflink.c:25:0:

p
