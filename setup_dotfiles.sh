#!/bin/bash

echo "~ kogyblack configuration setup ~"

# get the dir of the current script
script_dir="$( cd "$( dirname "$0" )" && pwd )"

echo "Configuring vim..."

# vim
if [[ ! -a ~/.vimrc ]]
then
  mkdir -p ~/.vim
  ln -s $script_dir/vim/nvimrc ~/.vimrc
fi

# nvim
XDG_CONFIG_HOME=~/.config
mkdir -p $XDG_CONFIG_HOME/nvim
if [[ ! -a $XDG_CONFIG_HOME/nvim/init.vim ]]
then
  ln -s ~/.vim $XDG_CONFIG_HOME/nvim
  ln -s $script_dir/vim/nvimrc $XDG_CONFIG_HOME/nvim/init.vim
fi

echo "Configuring tmux..."

# tmux
if [[ ! -a ~/.tmux.conf ]]
then
  ln -s $script_dir/tmux/tmux.conf ~/.tmux.conf
fi

echo "Configuring gdb (peda)..."

if [[ ! -a ~/.peda ]]
then
  git clone https://github.com/longld/peda.git ~/.peda
  echo "source ~/.peda/peda.py" >> ~/.gdbinit
fi

echo "Configuring git..."

source $script_dir/gitconfig_setup.sh

echo "Configuration complete!"

