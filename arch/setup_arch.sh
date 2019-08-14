#!/usr/bin/env bash

# XXX: WIP
# XXX: Consider using LARBS

if [[ $EID != 0 ]]; then
  echo "Root privileges are required!"
  sudo "$0" "$@"
  exit 1
fi

# xorg
echo "Installing xorg..."

pacman -S xorg-server xorg-xinit xorg-server-utils
if [[ $? != 0 ]]; then
  "Installing xorg... FAIL"
  exit $?
fi

echo "Installing xort... OK"

# gnome
pacman -S ttf-dejavu gnome
systemctl enable gdm

# TODO: verify nvidia or amd
# nvidia driver
pacman -S nvidia

# git
pacman -S git

# makepkg etc
pacman -S make fakeroot patch

# base devel
pacman -S base-devel

### TODO: use something better than yaourt!!!
# yaourt
#git clone https://aur.archlinux.org/package-query.git /tmp
#pushd /tmp/package-query
#makepkg -si
#popd
#
#git clone https://aur.archlinux.org/yaourt.git /tmp
#pushd /tmp/yaourt
#makepkg -si
#popd
#
#yaourt -Syu --aur

# yay
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si
popd

# ttf-fira-code
#yaourt -S ttf-fira-code
yay -S ttf-fira-code

# TODO: test suckless terminal? mlterm?
# konsole
#yaourt -S konsole
yay -S konsole

# neovim
#yaourt -S neovim neovim-symlinks
yay -S neovim neovim-symlinks

# fonts: (AUR) powerline-fonts-git
yay -S powerline-fonts-git
