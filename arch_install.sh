#!/bin/bash

#this project is meant to be the easiest way to install arch linux
#with your prefered desktop-enviroment
#You can see tutorial on youtube by distrotube

hostNameFile="/etc/hostname"

timedatectl set-ntp true
baseComponents(){
    #installing base components need to run install
    pacman -S --noconfirm sudo
    pacman -S --noconfirm git
}
diskChoser(){
    echo fdisk -l
    echo "Select disk you want to install arch linux ex---(/dev/sda)"
    read answer
    fdisk $answer

    #TODO done setting up disk

}
baseKernel(){
    pacstrap /mnt base linux linux-firmware
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt
}
clock(){
    #TODO changing zone and region
    hwclock --systohc
    echo "Un comment your locale ex---en_US.UTF-8  UTF-8"
    sleep 5s
    #TODO add more instructions
    nano /etc/locale.gen
    locale-gen
}
settingUpUsers(){
    echo "Set up users? (y,n)"
    read userSetup
    if [$userSetup == "y"] || [$userSetup == "yes"]
    then
        echo "Type in your host name"
        sleep 5s
        read hostname
        echo $hostname >> $hostNameFile
        echo "Add this 3 lines"
        echo "change your_host_name with hostname that you typed above"
        echo "127.0.0.1    localhost"
        echo "::1          localhost"
        echo "127.0.1.1    your_host_name.localdomain    your_host_name"
        echo "copy this and paste to file that will be in few seconds automaticly opened"
        sleep 50s
        #TODO hange it to auto
        nano /etc/hosts
        echo "Set up your ROOT password"
        passwd
        sleep 3s
        echo "type your username"
        read username
        useradd -m $username
        echo "type password for $username"
        passwd $username
        usermod -aG wheel,audio,video,optical,storage $username
    elif [$userSetup == "n"] || [$userSetup == "no"]
    then
        baseComponents
    fi
}

#TODO add desktop-enviroments

processingFunction(){
    diskChoser
    baseKernel
    clock
    settingUpUsers
    baseComponents
}

processingFunction
