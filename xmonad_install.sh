#!/bin/bash


Dependencies(){
    sudo pacman -S --noconfirm git
    sudo pacman -S --noconfirm qt5
    sudo pacman -Sy curl
}
alacritty(){
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup override set stable
    rustup update stable
    sudo pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
    cargo build --release
}
basePackages(){
    sudo pacman -Syu
    sudo pacman -Syy --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -Syy --noconfirm xmobar dmenu xterm picom nitrogen
    sudo systemctl enable sddm.service
}
webBrowser(){
    sudo pacman -S firefox
}
alacrittyInstallation(){
read -r -p "Do you want to install alacritty terminal [y,n]" alacrittyInput

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
            ;;
      *)
            echo "Invalid input"
            webBrowserInstallation
            ;;
esac
}
installation(){
    read -r -p "Do you want to install xmonad with all it's dependencies [y,n]" xmonadInput
    case $xmonadInput in
      [yY][eE][sS]|[yY])
            Dependencies
            basePackages
            alacrittyInstallation
            webBrowserInstallation
            echo "\033[0;32mFINISHED\033[0m"
            ;;
      [nN][oO]|[nN])
            echo "\033[0;31mCanceling\033[0m"
            exit
            ;;
      *)
            clear
            echo "Invalid input restarting"
            installation
            ;;
    esac

}
installation
