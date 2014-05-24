#!/bin/bash

# get the dir of the current script
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# profile
if [[ ! -a ~/.profile ]]
then
  ln -s $script_dir/profile ~/.profile
fi

# bash
if [[ ! -a ~/.bash_aliases ]]
then
  ln -s $script_dir/bash/bash_aliases ~/.bash_aliases
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


# vim plugins
# YouCompleteMe
if [[ ! -a ~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py ]]
then
  mkdir -p ~/.vim/bundle/YouCompleteMe/cpp/ycm
  ls -s $script_dir/vim/YouCompleteMe/ycm_extra_conf ~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py
fi
