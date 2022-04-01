#!/bin/bash
source install_inputs.sh

#----------------------------------------

#instalation control

#----------------------------------------

installation(){
    read -r -p "Do you want to install xmonad or awesome wm [1, 2, n]" xmonadInput
    case $xmonadInput in
          [xX][mM][oO][nN][aA][dD]|[1])
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
                clear
                sudo pacman -Syu --noconfirm
                clear
                echo "\e[32mInstallation finished\e[0m"
                ;;
          [aA][wW][eE][sS][oO][mM][eE]|[2])
                sudo pacman -Syu --noconfirm
                clear
                sudo pacman -S --noconfirm xorg-server xorg-xinit xterm awesome
                clear
                sddmInstallationAwesome
                clear
                sudo pacman -Syu --noconfirm
                clear
                ;;
          [nN][oO]|[nN])
                echo "\e[31mInstallation aborted\e[0m"
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
