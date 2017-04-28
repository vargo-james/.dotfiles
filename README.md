My configuration files are now version controlled. yay.

Automated Installation:

Requirements:

1. The project top level directory name must be .dotfiles and it must be 
located in the home directory.

2. The install.sh script requires GNU Stow.

Running install.sh will create symlinks in the right places so that programs
will see their configuration files. If a given configuration file already 
exists, then Stow will refuse to overwrite it and will print a warning letting
you know. If you want to replace the configuration, you must either delete 
the original or move it to a backup location. You can then rerun the 
install.sh script.

If you would like to uninstall the symlinks, you can do so by passing the -u
option to install.sh. Stow keeps track of the symlinks that it has deposited,
and it will remove them.


Manual Installation:

For each subdirectory, call stow if you would like to use its configuration
files. For example, "stow bash" will copy symlinks for all files in that 
subdirectory, (.bashrc and .bash_profile). To uninstall them later, call 
"stow -D".
