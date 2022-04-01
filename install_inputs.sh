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
Dependencies(){
    sudo pacman -S --noconfirm git
    #qt 5 installation for sddm to work
    sudo pacman -S --noconfirm qt5
    sudo pacman -S --noconfirm curl
}
basePackages(){
    sudo pacman -Syu
    mkdir ~/.config/xmonad/
    sudo pacman -S --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -S --noconfirm dmenu xterm nitrogen
    sudo systemctl enable sddm
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
read -r -p "Do you want to install alacritty terminal [y,n]" alacrittyInput

inputForm $alacrittyInput alacrittyPackages alacrittyPackagesNo alacrittyInstallation
}


webBrowserInstallation(){
read -r -p "Do you want to install firefox [y,n]" firefox

inputForm $firefox webBrowser exit webBrowserInstallation
}

