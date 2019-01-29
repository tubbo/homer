#!/usr/bin/env homer
#
# Short description of the command

name=$1

if [[ -z $name ]]; then
  echo "You must enter a name"
  exit 1
fi

zparseopts -K -- r:=remove m:=message

if [ -n "${remove+x}" ]; then
  action='Remove'
else
  action='Add'
fi

if [[ -z $message ]]; then
  message="${action} COMMAND ${name}"
fi

case "$action" in
  Add)
    ;;
  Remove)
    ;;
esac
