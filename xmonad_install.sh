#!/bin/bash

xmobarInstallation_status = 0

inputForm(){

#1 - input name
#2 - packages to install
#3 - what next script
#4 - what to script to repeat

case $1 in
      [yY][eE][sS]|[yY])
            $2
            ;;
      [nN][oO]|[nN])
            $3
            ;;
      *)
            echo "Invalid input"
            $4
            ;;
esac
}
Dependencies(){
    sudo pacman -S --noconfirm git
    #qt 5 installation for sddm to work
    sudo pacman -S --noconfirm qt5
    sudo pacman -S --noconfirm curl
}

alacrittyPackages(){
    if [$xmobarInstallation_status == 1]
    then
        #copying xmonad.hs file to config path
        cd alacritty/alacritty_xmobar/
        mv xmonad.hs ~/.config/xmonad/xmonad.hs
        #for testing
        echo "alacritty with xmobar"
        sleep 10s
        cd
    else
        #copying xmonad.hs file to config path
        cd alacritty
        mv xmonad.hs ~/.config/xmonad/xmonad.hs
        #for testing
        echo "alacritty without xmobar"
        sleep 10s
        cd
    fi
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
alacrittyPackagesNo(){
    if [$xmobarInstallation_status == 1]
    then
        #copying xmonad.hs file to config path
        cd normal/normal_xmobar/
        mv xmonad.hs ~/.config/xmonad/xmonad.hs
        #for testing
        echo "normal with xmobar"
        sleep 10s
        webBrowserInstallation
    else
        cd normal
        mv xmonad.hs ~/.config/xmonad/xmonad.hs
        echo "normal without xmobar"
        sleep 10s
        webBrowserInstallation
    fi

}
basePackages(){
    sudo pacman -Syu
    mkdir ~/.config/xmonad/
    sudo pacman -S --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -S --noconfirm dmenu xterm nitrogen
    sudo systemctl enable sddm
}
webBrowser(){
    sudo pacman -S --noconfirm firefox
}
xmobarPackages(){
    xmobarInstallation-status = 1
    mkdir -p ~/.config/xmobar
    sudo pacman -S --noconfirm xmobar
}
picomPackages(){
    sudo pacman -S --noconfirm picom
    mkdir -p .config/picom
}

#----------------------------------------

#instalation inputs

#----------------------------------------

sddmInstallation(){
read -r -p "Do you want to install sddm or lightdm or nothing [1,2,n]" sddmInput

case $sddmInput in
      [sS][dD][dD][mM]|[1])
            sudo pacman -S --noconfirm sddm
            sudo systemctl enable sddm
            ;;
      [lL][iI][gG][hH][tT][dD][mM]|[2])
            sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
            sudo systemctl enable lightdm
            ;;
      [nN][oO]|[nN])
            xmobarInstallation
            ;;
      *)
            echo "Invalid input"
            sddmInstallation
            ;;
esac
}


xmobarInstallation(){
read -r -p "Do you want to install xmobar [y,n]" xmobarInput

inputForm $xmobarInput xmobarPackages picomInstallation xmobarInstallation
}


picomInstallation(){
read -r -p "Do you want to install picom(It is needed to run xmonad) [y,n]" picomInput

inputForm $picomInput picomPackages alacrittyInstallation picomInstallation
}


alacrittyInstallation(){
read -r -p "Do you want to install alacritty terminal(You need to set it up) [y,n]" alacrittyInput

inputForm $alacrittyInput alacrittyPackages alacrittyPackagesNo alacrittyInstallation
}


webBrowserInstallation(){
read -r -p "Do you want to install firefox [y,n]" firefox

inputForm $firefox webBrowser exit webBrowserInstallation
}


#----------------------------------------

#instalation control

#----------------------------------------


installation(){
    read -r -p "Do you want to install xmonad with all it's dependencies(xmobar, dmenu, xorg, nitrogen) [y,n]" xmonadInput
    case $xmonadInput in
          [yY][eE][sS]|[yY])
            clear
            basePackages
            clear
            Dependencies
            clear
            sddmInstallation
            clear
            xmobarInstallation
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
