function join(array, separator, \
              result, i, len) {
	len = length(array)
	if (len > 0) {
		result = array[0]
		for (i = 1; i < len; ++i)
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
		retval = array[0]
		if (len > 1)
		{
			for (i = len - 2; i >= 0; --i)
				array[i] = array[i + 1]
		}
		delete array[len - 1]
	}
	return retval
}

BEGIN {
	getline MAX_LINES < SUPPRESSIONS
	pattern[0] = ""
	while((getline line < SUPPRESSIONS) > 0)
		if (line ~ /^#/)
			continue
		else if (line ~ /^$/)
		{
			if (length(pattern[length(pattern) - 1]))
				pattern[length(pattern)] = ""
		}
		else
			pattern[length(pattern) - 1] = pattern[length(pattern) - 1] line
	if (length(pattern[length(pattern) - 1]) == 0)
		delete pattern[length(pattern) - 1]
	split("", text)
}

{
	print "---"
	for (i in text)
	{
		print i ": " text[i]
	}
	text[length(text) + 1] = $0
	if (length(text) > MAX_LINES)
	{
		while (length(text) > MAX_LINES)
		{
			print pop(text)
		}
	}
	joined = join(text, "\n")
	
	matched = 0
	print "joined:  \"" joined  "\""
	for (i in pattern)
	{
		matcher = "^" pattern[i]
		if (sub(matcher, "", joined))
		{
			print "matcher: \"" matcher "\""
			matched = 1
			break
		}
	}
	print "unmatched: \"" joined "\""
	split(joined, text, "\n")
	
	fflush()
}

END {
	print join(text, "\n")
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
