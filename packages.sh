XMOBARINSTALLATION_STATUS=0

#----------------------------------------

#packages

#----------------------------------------

alacrittyPackages(){
    if [ $XMOBARINSTALLATION_STATUS == 1 ]
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
    if [ $XMOBARINSTALLATION_STATUS == 1 ]
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
webBrowser(){
    sudo pacman -S --noconfirm firefox
}
xmobarPackages(){
    XMOBARINSTALLATION_STATUS=1
    mkdir -p ~/.config/xmobar
    sudo pacman -S --noconfirm xmobar
    picomInstallation
}
picomPackages(){
    sudo pacman -S --noconfirm picom
    mkdir -p .config/picom
    alacrittyInstallation
}
Dependencies(){
    sudo pacman -S --noconfirm git
    #qt 5 installation for sddm to work
    sudo pacman -S --noconfirm qt5
    sudo pacman -S --noconfirm curl
}
basePackages(){
    sudo pacman -Syu --noconfirm
    mkdir ~/.config/xmonad/
    sudo pacman -S --noconfirm xorg sddm xmonad xmonad-contrib
    sudo pacman -S --noconfirm dmenu xterm nitrogen
    sudo systemctl enable sddm
}
