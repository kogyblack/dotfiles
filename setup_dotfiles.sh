#!/bin/bash

echo "~ kogyblack configuration setup ~"

# TODO: Download zsh + oh-my-zsh and change theme

# get the dir of the current script
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# dircolors (on WSL)
osrelease="$(cat /proc/sys/kernel/osrelease)"
if [[ $osrelease == *"Microsoft"* && ! -a ~/.dircolors ]]
then
  echo -n "Configuring dircolors (on WSL)... "
  ln -s $script_dir/dircolors ~/.dircolors

  new_line='eval `dircolors ~/.dircolors`'
  extra_lines="zstyle ':completion:*:default' list-colors "'${(s.:.)LS_COLORS}'"\nautoload -Uz compinit\ncompinit"
  grep -qF "$new_line" ~/.zshrc || echo -e "\n$new_line\n$extra_lines" >> ~/.zshrc

  echo "OK! (must restart terminal)"
fi

# vim
echo -n "Configuring vim... "

if [[ -a ~/.vimrc ]]
then
  echo ".vimrc found."
else
  mkdir -p ~/.vim
  ln -s $script_dir/vim/nvimrc ~/.vimrc
  echo "OK!"
fi

# nvim
echo -n "Configuring nvim... "

XDG_CONFIG_HOME=~/.config
mkdir -p $XDG_CONFIG_HOME/nvim
if [[ -a $XDG_CONFIG_HOME/nvim/init.vim ]]
then
  echo "init.vim found."
else
  ln -s ~/.vim $XDG_CONFIG_HOME/nvim
  ln -s $script_dir/vim/nvimrc $XDG_CONFIG_HOME/nvim/init.vim
  echo "OK!"
fi

echo -n "Configuring tmux... "

# tmux
if [[ -a ~/.tmux.conf ]]
then
  echo ".tmux.conf found."
else
  ln -s $script_dir/tmux/tmux.conf ~/.tmux.conf
  echo "OK!"
fi

echo -n "Configuring gdb (peda)... "

if [[ -a ~/.peda ]]
then
  echo ".peda found."
else
  git clone https://github.com/longld/peda.git ~/.peda
  echo "source ~/.peda/peda.py" >> ~/.gdbinit
  echo "OK!"
fi

echo -n "Configuring git..."
source $script_dir/gitconfig_setup.sh
echo "OK!"

echo "Configuration complete!"

