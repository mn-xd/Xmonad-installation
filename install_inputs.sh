source packages.sh

#----------------------------------------

#install inputs

#----------------------------------------

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

sddmInstallationAwesome(){
read -r -p "Do you want to install sddm or lightdm or nothing [1,2,n]" sddmAwInput

case $sddmAwInput in
      [sS][dD][dD][mM]|[1])
            sudo pacman -S --noconfirm sddm
            sudo systemctl enable sddm
            ;;
      [lL][iI][gG][hH][tT][dD][mM]|[2])
            sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
            sudo systemctl enable lightdm
            ;;
      [nN][oO]|[nN])
            sudo pacman -Syu --noconfirm
            clear
            exit
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

inputForm $picomInput picomPackages alacrittyInstallation  picomInstallation
}


alacrittyInstallationAwesome(){
read -r -p "Do you want to install alacritty terminal [y,n]" alacrittyInputAw

inputForm $alacrittyInputAw alacrittyPackagesAw alacrittyPackagesNoAw alacrittyInstallationAwesome
}

alacrittyInstallation(){
read -r -p "Do you want to install alacritty terminal [y,n]" alacrittyInput

inputForm $alacrittyInput alacrittyPackages alacrittyPackagesNo alacrittyInstallation
}


webBrowserInstallation(){
read -r -p "Do you want to install firefox [y,n]" firefox

inputForm $firefox webBrowser exit webBrowserInstallation
}

