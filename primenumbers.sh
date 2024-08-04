#!/usr/bin/env bash
<<comm
This program finds prime numbers
from 1 to user input.
complexity is O(n2)
comm
chek() {
  local flag=0
  for((cnt=2;cnt<$1;cnt++))
  do
    mod=$(($1%$cnt))
    if [[ $mod -eq 0 ]] 
    then
      flag=1
      break
    fi
  done
  if [[ $flag -eq 0 ]]
  then 
     printf " $1  "
  fi

}
read -p "Prime numbers from 1 to n? " a
for ((n=2;n<=$a;n++))
do
   chek $n

done
echo ""
