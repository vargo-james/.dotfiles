#!/bin/sh

script_name="install.sh"
cd ~/.dotfiles

dir=$pwd

if [ $# -eq 0 ]; then
  for file in *; do
    if [ ${file} != ${script_name} ]; then
      stow ${file}
    fi
  done

  cp ~/.dotfiles/install.sh ~/bin/install-dotfiles

  cd $dir
  return 0;
fi

if [ "$1" = '-u' ]; then
  for rmfile in *; do
    if [ ${rmfile} != ${script_name} ]; then
      stow -D ${rmfile} ${silence}
    fi
  done
  rm ~/bin/dotify
  cd $dir
  return 0;
fi

echo "Usage: $0 [-u]"


