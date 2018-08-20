#!/bin/bash

function readJson {
  UNAME_STR=`uname`
  if [[ "$UNAME_STR" == 'Linux' ]]; then
    SED_EXTENDED='-r'
  elif [[ "$UNAME_STR" == 'Darwin' ]]; then
    SED_EXTENDED='-E'
  fi;

  VALUE=`grep -m 1 "\"${2}\"" ${1} | sed ${SED_EXTENDED} 's/^ *//;s/.*: *"//;s/",?//'`

  if [ ! "$VALUE" ]; then
    echo "Error: Cannot find \"${2}\" in ${1}" >&2;
    exit 1;
  else
    echo ${VALUE} ;
  fi;
}

VERSION=`readJson src/manifest.json version` || exit 1;

NAME='nopopup_'${VERSION}
rm -fR ${NAME}/
cp -R src/ ${NAME}/
zip -r zip/${NAME}.zip ${NAME}/*
rm -R ${NAME}/
