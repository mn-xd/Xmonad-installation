#!/bin/bash

#TODO yay install with username prompt
Dependencies(){
    sudo pacman -S --noconfirm git
    #qt 5 installation for sddm to work
    sudo pacman -S --noconfirm qt5
    sudo pacman -S --noconfirm curl
}

alacritty(){
    cd alacritty
    mv xmonad.hs ~/.xmonad/xmonad.hs
    cd
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    rustup override set stable
    rustup update stable
    sudo pacman -S --noconfirm cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
    cargo build --release
    mkdir -p .config/alacritty/
    #adding alacritty to path to work anywhere
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
}

basePackages(){
    sudo pacman -Syu
    sudo pacman -S --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -S --noconfirm xmobar dmenu xterm nitrogen
    mkdir -p ~/.config/xmobar
    sudo systemctl enable sddm
}

webBrowser(){
    sudo pacman -S --noconfirm firefox
}

picomInstallation(){
read -r -p "Do you want to install picom(It is needed to run xmonad) [y,n]" picomInput

case $picomInput in
      [yY][eE][sS]|[yY])
            sudo pacman -S --noconfirm picom
            mkdir -p .config/picom
            ;;
      [nN][oO]|[nN])
            alacrittyInstallation
            ;;
      *)
            echo "Invalid input"
            picomInstallation
            ;;
esac
}
alacrittyInstallation(){
read -r -p "Do you want to install alacritty terminal(You need to set it up) [y,n]" alacrittyInput

case $alacrittyInput in
      [yY][eE][sS]|[yY])
            alacritty
            ;;
      [nN][oO]|[nN])
            webBrowserInstallation
            ;;
      *)
            echo "Invalid input"
            alacrittyInstallation
            ;;
esac
}
webBrowserInstallation(){
read -r -p "Do you want to install firefox [y,n]" firefox

case $firefox in
      [yY][eE][sS]|[yY])
            webBrowser
            ;;
      [nN][oO]|[nN])
            exit
            echo "\033[0;32mFINISHED\033[0m"
            ;;
      *)
            echo "Invalid input"
            webBrowserInstallation
            ;;
esac
}
installation(){
    read -r -p "Do you want to install xmonad with all it's dependencies(xmobar, dmenu, xorg, nitrogen) [y,n]" xmonadInput
    case $xmonadInput in
          [yY][eE][sS]|[yY])
            clear
            basePackages
            clear
            Dependencies
            clear
            picomInstallation
            clear
            alacrittyInstallation
            clear
            webBrowserInstallation
            echo "\033[0;32mFINISHED\033[0m"
            ;;
      [nN][oO]|[nN])
            echo "\033[0;31mCanceling\033[0m"
            exit
            ;;
      *)
            clear
            echo "Invalid input"
            installation
            ;;
    esac
}
installation
