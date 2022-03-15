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
read alacritty1

if ["$alacritty1" == "y"] || ["$alacritty1" == "yes"];
then
	alacritty
elif ["$alacritty1" == "n"] || ["$alacritty1" == "no"];
then
	:
else
	echo "Input not recognised, must be yes or no"
	alacrittyInstallation
fi
}
webBrowserInstallation(){
read firefox

if ["$firefox" == "y"] || ["$firefox" == "yes"];
then
	webBrowser
elif ["$firefox" == "n"] || ["$firefox" == "no"];
then
	:
else
	echo "Input not recognised, must be yes or no"
	webBrowserInstallation
fi
}
installation(){
    echo "Do you want to install xmonad with all it's dependencies (y,n)"
    read xmonad
    if ["$xmonad" == "y"] || ["$xmonad" == "yes"];
		then
			Dependencies
    	basePackages
      echo "Do you want to install alacritty terminal (y,n)"
			alacrittyInstallation
			echo "Do you want to install firefox (y,n)"
			webBrowserInstallation
    elif ["$xmonad" == "n"] || ["$xmonad" == "no"];
		then
      :
    fi

}
installation
