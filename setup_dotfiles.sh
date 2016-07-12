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
  ln -s $script_dir/bash/inputrc $HOME/.inputrc
fi

# vim
if [[ ! -a ~/.vimrc ]]
then
  mkdir -p $HOME/.vim
  ln -s $script_dir/vim/nvimrc $HOME/.vimrc
fi

# nvim
XDG_CONFIG_HOME=$HOME/.config
mkdir -p $XDG_CONFIG_HOME/nvim
if [[ ! -a $XDG_CONFIG_HOME/nvim/init.vim ]]
then
  ln -s ~/.vim $XDG_CONFIG_HOME/nvim
  ln -s $script_dir/vim/nvimrc $XDG_CONFIG_HOME/nvim/init.vim
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
