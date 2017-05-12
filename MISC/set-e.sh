# echo, local and export are commands that always have exit status 0
echo "$(/bin/false)"
local foo="$(/bin/false)"
export foo="$(/bin/false)"

# the last command substitution has exit status 0
foo="$(/bin/false)$(/bin/true)"
