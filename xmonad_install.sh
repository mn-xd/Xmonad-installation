#!/bin/bash


Dependencies(){
    sudo pacman -S --noconfirm git
    sudo pacman -S --noconfirm qt5
    sudo pacman -Sy --noconfirm curl
}
alacritty(){
    cd
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	source $HOME/.cargo/env
    rustup override set stable
    rustup update stable
    sudo pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
    cargo build --release
    mkdir -p .config/alacritty/
}
basePackages(){
    sudo pacman -Syu
    sudo pacman -Syy --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -Syy --noconfirm xmobar dmenu xterm picom nitrogen
    mkdir -p .config/picom
    mkdir -p .config/xmobar
    sudo systemctl enable sddm.service
}
webBrowser(){
    sudo pacman -S firefox
}
alacrittyInstallation(){
read -r -p "Do you want to install alacritty terminal(you need to set it up) [y,n]" alacrittyInput

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
            clear
            Dependencies
            clear
            basePackages
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
