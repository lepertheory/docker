function evict_text () {
	while (length(text) > MAX_LINES)
		print pop(text)
}

function filter_text(\
                     matched, value) {
	matched = 0
	value = join(text, "\n")
	for (i in pattern)
	{
		if (match(value, "^" pattern[i]))
		{
			matched = substr(value, 0, RLENGTH)
			value = substr(value, RLENGTH + 1)
			break
		}
	}
	split(value, text, "\n")
	return matched
}

function join(array, separator, \
              result, i, len) {
	len = length(array)
	if (len > 0) {
		result = array[1]
		for (i = 2; i <= len; ++i)
			result = result separator array[i]
	}
	else
		result = ""
	return result
}

function pop(array, \
             retval, i, len) {
	len = length(array)
	if (len > 0)
	{
		retval = array[1]
		if (len > 1)
			for (i = 1; i < len; ++i)
				array[i] = array[i + 1]
		delete array[len]
	}
	return retval
}

BEGIN {
	getline MAX_LINES < SUPPRESSIONS
	pattern[1] = ""
	while((getline line < SUPPRESSIONS) > 0)
		if (line ~ /^#/)
			continue
		else if (line ~ /^$/)
		{
			if (length(pattern[length(pattern)]) > 0)
				pattern[length(pattern) + 1] = ""
		}
		else
			pattern[length(pattern)] = pattern[length(pattern)] line
	if (length(pattern[length(pattern)]) == 0)
		delete pattern[length(pattern)]
	split("", text)
}

{
	text[length(text) + 1] = $0
	evict_text()
	filter_text()
	fflush()
}

END {
	while (length(text))
		if (!filter_text())
			print pop(text)
}

#/^\/mnt\/lfs\/sources\/binutils-2\.29\/(zlib|binutils|gas|gprof|ld|bfd|opcodes)\/configure: line [0-9]+: \/usr\/bin\/file: No such file or directory$/ { print "FART" }
#fflush("")


# !/usr/bin/env sed --quiet --regexp-extended --unbuffered
#
#\%^/mnt/lfs/sources/binutils-2\.29/(zlib|binutils|gas|gprof|ld|bfd|opcodes)/configure: line [0-9]+: /usr/bin/file: No such file or directory$%
#ar: `u' modifier ignored since `D' is the default \(see `U'\)
#In file included from \.\./\.\./bfd/elflink.c:25:0:
#
#p
