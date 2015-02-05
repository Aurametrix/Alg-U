array=("a c" b f "3 5")
IFS=$'\n' sorted=($(sort <<<"${array[*]}"))
printf "[%s]\n" "${sorted[@]}"
