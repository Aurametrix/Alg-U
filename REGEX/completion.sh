function _fizzbuzz () {
  length=${#COMP_WORDS[@]}
  number=$((length - 1))
  if   ! ((number % 15)); then COMPREPLY=(fizzbuzz)
  elif ! ((number % 3));  then COMPREPLY=(fizz)
  elif ! ((number % 5));  then COMPREPLY=(buzz)
  else                         COMPREPLY=($number)
  fi
}
complete -F _fizzbuzz fizzbuzz
