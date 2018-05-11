#!/bin/bash
#
# 54ysh -- a shell-like speaking tool for mac
#
# copyright (c) 2018 Cj-bc
# 
# This software is released under MIT License.
# http://opensource.org/license/mit-license.php

type say >/dev/null 2>&1
say_found=$?

function say_impl() {
  if [ $say_found -eq 0 ]; then
    say $@
  else
    ./say_wrapper.sh $@
  fi
}

if [ -p /dev/stdin ]
then
  while read userInput
  do
#    userInput=$(cat -)
    if [ "$(echo "$userInput" | nkf -g)" = "ASCII" ]
    then
      say_impl -v alex "$userInput"
    else
      say_impl -v kyoko "$userInput"
    fi
  done
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
    say_impl -v alex $userInput
  else
    say_impl -v kyoko $userInput
  fi
  
  read userInput
  echo -n "> "
done

echo "finished correctly"
return 0
