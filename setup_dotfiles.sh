#!/bin/bash

echo "~ kogyblack configuration setup ~"

# get the dir of the current script
script_dir="$( cd "$( dirname "$0" )" && pwd )"

# OS info
# WSL: *"Microsoft"*
# Arch: *"ARCH"*
os="$(cat /proc/sys/kernel/osrelease)"

#if [[ $UID != 0 ]];
#then
#  echo "Run as root is required:"
#  echo "sudo $0 $*"
#  exit 1
#fi

#TODO: Install nerd fonts

# ZSH + Oh My Zsh
echo -n "Configuring zsh... "
if command -v zsh >/dev/null 2>&1 ;
then
  echo "zsh found!"
else
  echo ""

  echo "Installing zsh..."
  if [[ $os == *"ARCH"* ]] ; then
    yaourt -S zsh
  else # WSL or Ubuntu
    sudo apt install zsh -y
  fi
  echo "Installing zsh... OK!"

  echo "Installing oh-my-zsh..."
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sed 's/env zsh//')"
  echo "Installing oh-my-zsh... OK!"

  echo -n "Copying custom zsh theme... "
  ln -s $script_dir/zsh/kogyblack.zsh-theme $HOME/.oh-my-zsh/themes/kogyblack.zsh-theme
  echo "OK!"

  echo -n "Copying zshrc... "
  rm -f $HOME/.zshrc
  ln -s $script_dir/zsh/zshrc $HOME/.zshrc
  echo "OK!"
fi

# dircolors (on WSL)
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

