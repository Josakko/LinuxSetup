#!/bin/bash


#if [ "$EUID" -ne 0 ]; then
#  echo "This script must be run as root!"
#  exit 1
#fi


#repos
#sudo cp files/sources.list /etc/apt/sources.list
echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware" | sudo tee -a /etc/modprobe.d/blacklist.conf

sudo apt update
sudo apt full-upgrade -y


#terminal & zsh
sudo apt install terminator -y
sudo apt install tilix -y

#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#cp dotfiles/zshrc ~/.zshrc

cp dotfiles/bashrc ~/.bashrc
sudo apt update


#dotfiles
cp dotfiles/face ~/.face
cp dotfiles/face.icon ~/.face.icon

cp dotfiles/nvidia-settings-rc ~/.nvidia-settings-rc

cp files/Josakko.code-profile ~/Documents/Josakko.code-profile


#background
sudo cp images/user.png /usr/share/images/desktop-base/user.png

sudo cp images/background.png /usr/share/images/desktop-base/default
sudo cp images/background.png /usr/share/images/desktop-base/desktop-background

sudo cp images/background-login.png /usr/share/desktop-base/kali-theme/login/background
sudo cp files/lightdm.conf /etc/lightdm/lightdm.conf
sudo cp files/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf


#grub
sudo cp images/grub/grub-4x3.png /boot/grub/themes/kali/grub-4x3.png
sudo cp images/grub/grub-16x9.png /boot/grub/themes/kali/grub-16x9.png 
sudo cp images/grub/theme.txt /boot/grub/themes/kali/theme.txt

sudo cp images/grub/grub-4x3.png /usr/share/grub/themes/kali/grub-4x3.png
sudo cp images/grub/grub-16x9.png /usr/share/grub/themes/kali/grub-16x9.png 
sudo cp images/grub/theme.txt /usr/share/grub/themes/kali/theme.txt

sudo cp images/grub/grub-16x9.png /usr/share/images/desktop-base/desktop-grub.png


#docker
#sudo apt update
#
#sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#sudo apt update
#
#sudo apt install docker-ce docker-ce-cli containerd.io -y
#sudo systemctl start docker
#sudo docker --version
#sudo systemctl stop docker


#ssh server
sudo systemctl stop ssh
sudo systemctl disable ssh


#apps
sudo apt update
sudo apt upgrade -y

#sudo apt install snapd -y
sudo apt install docker.io -y
sudo apt install gcc -y 
sudo apt install default-jdk -y 
sudo apt install golang -y 
sudo apt install ghex -y 
sudo apt install ffmpeg -y
sudo apt install neovim -y 
sudo apt install obs-studio -y
sudo apt install nodejs -y
sudo apt install npm -y
sudo apt install lua5.3 -y
sudo apt install php -y
sudo apt install openssl -y
sudo apt install qemu -y
sudo apt install tor torbrowser-launcher -y
sudo apt install lynis -y
sudo apt install make -y
sudo apt install ruby-full -y
sudo apt install rustc -y
sudo apt install apt-listbugs -y
sudo apt install apt-listchanges -y
sudo apt install apt-show-versions -y
sudo apt install htop -y


#vs code / vs codium
install_vs() {
    echo "Install? 
    1. VS code
    2. VS codium 
    3. both
    4. none"
    read choice

    #sudo systemctl start snapd.socket
    

    if [[ "$choice" == "1" ]]; then
        #sudo snap install code --classic
        sudo apt update
        sudo apt install software-properties-common apt-transport-https
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg –dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c ‘echo “deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repo vscode stable main” > /etc/apt/sources.list.d/vscode.list’
        sudo apt update
        sudo apt install code


    elif [[ "$choice" == "2" ]]; then
        sudo apt install snapd -y
        sudo systemctl start snapd.socket
        sudo snap install codium --classic

    elif [[ "$choice" == "3" ]]; then
        #sudo snap install code --classic
        sudo apt update
        sudo apt install software-properties-common apt-transport-https
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg –dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c ‘echo “deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repo vscode stable main” > /etc/apt/sources.list.d/vscode.list’
        sudo apt update
        sudo apt install code

        sudo apt install snapd -y
        sudo snap install codium --classic

    elif [[ "$choice" == "4" ]]; then
        :

    else
        echo "Inalid choice!"
        install_vs
    fi
}

install_vs


#ghidra
install_ghidra() {
    #echo Download ghidra from https://github.com/NationalSecurityAgency/ghidra/releases
    #echo Enter path to downloaded file or leave empty to skip ghidra installation...
    #read path
    
    sudo wget -O /home/ghidra.zip https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_10.3.2_build/ghidra_10.3.2_PUBLIC_20230711.zip
    path=/home/ghidra.zip

    ghidra_folder="ghidra_10.3.2_PUBLIC"

    if [ "$path" == "" ]; then
        :

    elif [ -e $path ]; then
        sudo unzip $path -d /usr/share
        sudo mv /usr/share/$ghidra_folder /usr/share/ghidra

    else
        #echo Invalid path!
        #install_ghidra
        :

    fi
}

install_ghidra


#dependecies
sudo npm install ts-node -g
sudo npm install pkg -g

pip3 install -r files/req3.txt
pip install -r files/req.txt


#security
lock_grub() {
    echo "Set password for grub bootloader [Y/n]?"
    read grub_choice

    if [ "$grub_choice" == "y" ] || [ "$grub_choice" == "Y" ]; then
        echo "Enter username for grub:"
        read grub_username

        echo "Enter PBKDF2 password hash for grub (use "grub-mkpasswd-pbkdf2" command):"
        read grub_password_hash

        echo "
cat << EOF
set superusers="$grub_username"
password_pbkdf2 $grub_username $grub_password_hash
EOF
        " | sudo tee -a /etc/grub.d/00_header

        sudo update-grub


    elif [ "$grub_choice" == "n" ] || [ "$grub_choice" == "N" ]; then
        :

    else
        echo Invalid choice...
        lock_grub

    fi
}

disable_usb() {
    echo "Disable USB driver [Y/n]?"
    read usb_choice

    if [ "$usb_choice" == "y" ] || [ "$usb_choice" == "Y" ]; then
        echo "blacklist usb-storage" | sudo tee -a /etc/modprobe.d/blacklist.conf

    elif [ "$usb_choice" == "n" ] || [ "$usb_choice" == "N" ]; then
        :

    else
        echo Invalid choice...
        disable_usb

    fi
}

harden_login() {
    echo "Harden /etc/login.defs [Y/n]?"
    read harden_choice

    if [ "$harden_choice" == "y" ] || [ "$harden_choice" == "Y" ]; then
        sudo cp files/login.defs /etc/login.defs

    elif [ "$harden_choice" == "n" ] || [ "$harden_choice" == "N" ]; then
        :

    else
        echo Invalid choice...
        harden_login

    fi
}

trash_emptying() {
    echo "Schedule trash emptying on reboot or shutdown [Y/n]?"
    read trash_emptying_choice

    cd $path

    if [ "$trash_emptying_choice" == "y" ] || [ "$trash_emptying_choice" == "Y" ]; then
        chmod +x files/empty_trash.sh

        sudo cp files/empty_trash.sh /etc/rc0.d/K01empty_trash
        sudo cp files/empty_trash.sh /etc/rc6.d/K01empty_trash

        sudo ln -s /etc/rc0.d/K01empty_trash /etc/rc0.d/K01empty_trash.sh
        sudo ln -s /etc/rc6.d/K01empty_trash /etc/rc6.d/K01empty_trash.sh


    elif [ "$trash_emptying_choice" == "n" ] || [ "$trash_emptying_choice" == "N" ]; then
        :

    else
        echo Invalid choice...
        trash_emptying

    fi
}

lock_grub
disable_usb
harden_login
trash_emptying


#finish
sudo apt update
sudo apt full-upgrade -y

run_lynis() {
    echo "Run lynis now [Y/n]?"
    read lynis_choice

    if [ "$lynis_choice" == "y" ] || [ "$lynis_choice" == "Y" ]; then
        sudo lynis audit system

    elif [ "$lynis_choice" == "n" ] || [ "$lynis_choice" == "N" ]; then
        :

    else
        echo Invalid choice...
        run_lynis

    fi
}

run_lynis
#files/empty_trash.sh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp dotfiles/zshrc ~/.zshrc

