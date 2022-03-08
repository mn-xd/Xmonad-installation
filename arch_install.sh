#You can see tutorial on youtube by distrotube

timedatectl set-ntp true
baseComponents(){
    #installing base components need to run install
    pacman -S sudo
    pacman -S git
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
    pacman -S nano
    echo "Un comment your locale ex---en_US.UTF-8  UTF-8"
    sleep 5s
    #TODO add more instructions
    nano /etc/locale.gen
    locale-gen
}
settingUpUsers(){
    echo "Type in your host name"
    sleep 5s
    nano /etc/hostname
    sleep 30s
    echo "Add this 3 lines"
    echo "change your_host_name with hostname that you typed above"
    echo "127.0.0.1    localhost"
    echo "::1          localhost"
    echo "127.0.1.1    your_host_name.localdomain    your_host_name"
    echo "copy this and paste to file that will be automaticly opened"
    sleep 20s
    nano /etc/hosts
    echo "Set up your ROOT password"
    passwd
    sleep 5s
    echo "type your username"
    read username
    useradd -m $username
    echo "type password for $username"
    passwd $username
    usermod -aG wheel,audio,video,optical,storage $username
}
