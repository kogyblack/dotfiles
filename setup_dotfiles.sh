#!/bin/bash

# get the dir of the current script
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# bash
#if [[ ! -a ~/.bash_aliases ]]
#then
#  ln -s $script_dir/bash/bash_aliases ~/.bash_aliases
#fi

if [[ ! -a ~/.inputrc ]]
then
  ln -s $script_dir/bash/inputrc ~/.inputrc
fi

# vim
if [[ ! -a ~/.vimrc ]]
then
  ln -s $script_dir/vim/vimrc ~/.vimrc
fi

# terminator
if [[ ! -a ~/.config/terminator/config ]]
then
  mkdir -p ~/.config/terminator
  ln -s $script_dir/terminator/config ~/.config/terminator/config
fi

# tmux
if [[ ! -a ~/.tmux.conf ]]
then
  ln -s $script_dir/tmux/tmux.conf ~/.tmux.conf
fi

if [[ ! -a ~/.tmux.conf.local ]]
then
  ln -s $script_dir/tmux/tmux.conf.local ~/.tmux.conf.local
fi

# gdb
if [[ ! -a ~/.gdbinit ]]
then
  ln -s $script_dir/gdb/gdbinit ~/.gdbinit
fi

source $script_dir/gitconfig_setup.sh
