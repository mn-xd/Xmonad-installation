#!/bin/bash
source packages.sh
source install_inputs.sh

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
