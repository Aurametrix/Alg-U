x=("1  2" "3  4")
y=(5 6)
sum=( "${x[@]}" "${y[@]}" )
 
for i in "${sum[@]}" ; do echo "$i" ; done

array=(
    a
    b
)
array+=(c)
if [ ${#array[@]} -gt 0 ]; then
    rm -- "${array[@]}"
fi
