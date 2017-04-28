#!/bin/sh

script_name="install.sh"
readme_name="README.md"
cd ~/.dotfiles

dir=$pwd

if [ $# -eq 0 ]; then
  for file in *; do
    if [ ${file} != ${script_name} ] && [ ${file} != ${readme_name} ]; then
      stow ${file}
    fi
  done

  cd $dir
  return 0;
fi

if [ $# -eq 1 ] && [ "$1" = '-u' ]; then
  for rmfile in *; do
    if [ ${rmfile} != ${script_name} ]; then
      stow -D ${rmfile} ${silence}
    fi
  done
  cd $dir
  return 0;
fi

echo "Usage: $0 [-u]"


