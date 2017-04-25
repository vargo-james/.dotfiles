#!/bin/sh

script_name=$(basename $0)

silence="1> /dev/null 2>&1"

if [ $# -eq 0 ]; then
  for file in *; do
    if [ $file != ${script_name} ]; then
      echo "stow ${file} ${silence}"
    fi
  done
  return 0;
fi

if [ $1 = '-u' ]; then
  echo "Please update stow"
  for file in *; do
    if [ $file != ${script_name} ]; then
      echo "stow -D ${file} ${silence}"
    fi
  done
  return 0;
fi

echo "Usage: $0 [-u]"


