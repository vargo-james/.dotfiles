# This file is sourced for bash logins.

if [ -r "${HOME}/.profile" ]; then
  . "${HOME}/.profile"
fi

if [ -r "${HOME}/.bashrc" ]; then
  . "${HOME}/.bashrc";
fi

