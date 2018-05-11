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
  userInput=$(cat -)
  if [ "echo "$userInput" | nkf -g)" = "ASCII" ]
  then
    say -v alex "$userInput" &
  else
    say -v kyoko "$userInput" &
  fi
  if [ -p /dev/stdout ]
  then
    echo "$userInput"
  fi
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
