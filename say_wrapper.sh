#!/bin/bash

function usage_exit() {
        echo "Usage: $0 [-v agent]" 1>&2
        exit 1
}

while getopts v:h OPT
do
    case $OPT in
        v)  VALUE_V=$OPTARG
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done

shift $((OPTIND - 1))

if [ -v VALUE_V ];then
  if [ "$VALUE_V" = "kyoko" ];then
    language=ja
  else
    language=en
  fi
else
  language=$(sed -e 's/^\(..\)_.*$/\1/g' <<< $LANG)
fi

tmpfile=$(mktemp)
if [ $language = "en" ]; then
  echo "$@" | espeak -w $tmpfile
elif [ $language = "ja"]; then
  echo "$@" | open_jtalk \
  -m /usr/share/hts-voice/nitech-jp-atr503-m001/nitech_jp_atr503_m001.htsvoice \
  -x /var/lib/mecab/dic/open-jtalk/naist-jdic \
  -ow $tmpfile
else
  echo "Language '$language' isn't supported"
  rm $tmpfile
  exit -1
fi
play -q $tmpfile
rm $tmpfile
