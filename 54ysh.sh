#!/bin/bash
#
# 54ysh -- a shell-like speaking tool for mac
#
# copyright (c) 2018 Cj-bc
# 
# This software is released under MIT License.
# http://opensource.org/license/mit-license.php


if [ -p /dev/stdin ]
then
  temp=$(mktemp /tmp/54ysh.stdin.tmp.XXXXXX)
  cat - > $temp
  while read userInput
  do
    if [ "$(echo "$userInput" | nkf -g)" = "ASCII" ]
    then
      say -v alex "$userInput"
    else
      say -v kyoko "$userInput"
    fi
    input=("${input[@]}" "$userInput")
  done < $temp
  if [ -p /dev/stdout ]
  then
    cat $temp
  fi

  rm $temp
  exit 0
fi

# Logo and info
cat <<EOT

=======     ===              ======  ==
==         = ==             ==       ==
==        =  ==             ==       ==  ==
=======  =   ==              =====   == =  ==
     == =========  =   ==        ==  ===    ==
     ==      ==     =  ==        ==  ==     ==
=======      ==      ====   =====    ==     ==
                       ==
                      ==
                     ==               by Cj-bc

speaking tool for mac.  ver.0.0.1

Type here
EOT
echo -n "> "

read userInput
echo -n "> "

while [ "$userInput" != ":q" ]
do
  if [ "$(echo $userInput | nkf -g)" = "ASCII" ]
  then
    say -v alex $userInput
  else
    say -v kyoko $userInput
  fi
  
  read userInput
  echo -n "> "
done

echo "finished correctly"
return 0
