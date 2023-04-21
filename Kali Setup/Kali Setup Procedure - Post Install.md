# Kali Setup Procedure - Post Install

These are the steps I do on a fresh Kali install. Some of the steps are specific to my Macbook.

<br/><br/><br/>


## Change Root Password:

```powershell
sudo -i passwd root
```
<br/><br/><br/>

## Create new SSH Keys:

:: Change to dir where ssh keys are located

```powershell
cd /etc/ssh
```
<br/>
:: Make folder to backup original ssh keys.

```powershell
sudo mkdir old_keys
```
<br/>
:: Move original ssh keys to the backup location.

```powershell
sudo mv ssh_host_* old_keys
```
<br/>
:: Verify that the original ssh keys have been relocated.

```powershell
ls
```
<br/>
:: Create new ssh keys.

```powershell
sudo dpkg-reconfigure openssh-server
```

<br/>
:: Verify that the new ssh keys have been created.

```powershell
ls
```
<br/>
:: Confirm that the new ssh keys have a different md5 hash from the originals

```powershell
sudo md5sum ssh_host_*
```
```powershell
sudo md5sum /etc/ssh/old_keys/ssh_host_*
```
<br/>
:: Remove old ssh keys.

```powershell
sudo rm -r old_keys
```
<br/>
:: Confirm the “old_keys” directory is gone

```powershell
ls
```
<br/><br/><br/>

## Uncomment both sources: 

```powershell
sudo nano /etc/apt/sources.list
```

<br/><br/><br/>

## Update System:

#### -- Run as root --
<br/>

```powershell
sudo apt-get update && sudo apt-get upgrade -y
```
<br/>

```powershell
sudo apt-get upgrade --fix-missing -y && sudo apt-get upgrade --fix-broken -y
```
<br/>

```powershell
sudo apt-get dist-upgrade -y
```
<br/>

```powershell
sudo apt-get dist-upgrade --fix-missing -y && sudo apt-get dist-upgrade --fix-broken -y
```

<br/><br/><br/>

## Remove orphaned “apt-get” packages dependencies & clears out local repository of retrieved package files:

#### -- Run as root --
<br/>


```powershell
sudo apt autoremove
```
```powershell
sudo apt-get clean
```

<br/><br/><br/>
## Install Git Repository:

:: Install
```powershell
sudo apt-get install git
```
<br/><br/><br/>

## Install GDebi Package Manager:

:: Install
```powershell
sudo apt-get install gdebi
```

<br/><br/><br/>

## Install WGET Package Manager:

:: Install
```powershell
sudo apt install wget
```


<br/><br/><br/>

## Install File-Roller Archive Manager:

:: Install
```powershell
sudo apt-get install unrar unace unrar p7zip zip unzip p7zip-full p7zip-rar file-roller -y
```



<br/><br/><br/>
## Macbook - Install WiFi Adapter B43 Firmware:
<br/>
This is required inorder for the internal WiFi adapter to work.

```powershell
sudo apt-get install firmware-b43-installer
```
<br/><br/><br/>

## Macbook - Disable Lid Switch:
<br/>
This will prevent the machine from shutting down or going to sleep when the lid is closed.
<br/><br/>

```powershell
sudo nano /etc/systemd/logind.conf
```
<br/><br/>
Uncomment the following configurations and set to "ignore".

```powershell
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```


<br/><br/><br/>
## Alfa AWUS036ACH External WiFi Adapter - Install Driver:
<br/>

:: Install
```powershell
sudo apt install -y linux-headers-$(uname -r) build-essential bc dkms git libelf-dev
```

```powershell
mkdir -p ~/src
```

```powershell
cd ~/src
```

```powershell
git clone https://github.com/morrownr/8812au-20210629.git
```

```powershell
cd ~/src/8812au-20210629
```
<br/>

Go with all default options when asked.
```powershell
sudo ./install-driver.sh
```
<br/>
Reboot
<br/><br/>
Plug in WiFi adapter




<br/><br/><br/>


## Install Visual Studio Code:

:: Google “vs code download”<br/>
:: Choose Debian architecture<br/>
:: Open terminal in Download folder<br/><br/>

The file name may be different than shown below in the command line.

:: Install
```powershell
sudo apt install ./code_1.74.0-1670260027_amd64.deb
```

<br/><br/><br/>


## Install Tor Browser:

:: Install
```powershell
sudo apt update
```
```powershell
sudo apt install -y tor torbrowser-launcher
```
<br/>

:: Run
```powershell
torbrowser-launcher
```
<br/><br/><br/>


## Install Konsole Multiplexer:

:: Install
```powershell
sudo apt-get install konsole -y
```

<br/><br/><br/>

## Install a terminator multiplexer:

:: Install Terminator
```powershell
sudo apt install terminator -y
```
<br/><br/>
:: Install Terminator Themes
Install Git Repository if not installed

Cool Themes: https://draculatheme.com/terminator

```powershell
cd ~/
```
```powershell
git clone https://github.com/dracula/terminator.git
```
```powershell
cd terminator
```
```powershell
./install.sh
```




<br/><br/><br/>

## Install Remmina RDP Client:

:: Install
```powershell
sudo apt-get install remmina -y
```

<br/><br/><br/>
## Install: OpenVas Scanner

#### -- Install and run as root --

<br/><br/>
:: Installation

```powershell
sudo apt-get install openvas
```
<br/>

:: On a fresh install, note the password displayed at the end of the setup. You will need it to connect you to the Web UI GSA (greenbone-security-assistant)

```powershell
sudo gvm-setup
```
<br/>

:: To update the data (CERT, SCAP, GVMD_DATA) from the feed server and to update the OpenVAS NVTs from Community Feed

```powershell
sudo gvm-feed-update
```
<br/>

:: It will check the setup and start the all the required services if everything is OK. You can now open your browser on https://127.0.0.1:9392 and use GVM.

```powershell
sudo gvm-check-setup
```
<br/>

:: Reset the admin password

```powershell
sudo -u _gvm gvmd --user=admin --new-password=<AdminPassword>
```
<br/>

:: To create a new gvm system user

```powershell
sudo runuser -u _gvm -- gvmd --create-user=<UserName> --password=<UserPassword>
```
<br/>

:: Create a new user with Admin role permissions.

```powershell
sudo gvmd --create-user=<UserName> --password=<UserPassword> --role=Admin
```
```powershell
sudo gvmd --inheritor=<UserName>
```
<br/>

:: Deleted admin Account

```powershell
sudo gvmd --delete-user=admin
```
<br/>

:: Reset the user password

```powershell
sudo runuser -u _gvm -- gvmd --create-user=<UserName> --new-password=<UserPassword>
```
<br/>

:: To start the GVM services, use:

```powershell
sudo gvm-start
```
<br/>

:: To stop the GVM services, use:

```powershell
sudo gvm-stop
```
<br/>

:: GVM Versions Info

```powershell
gvmd --version
```
<br/>

:: Access GVM Web Interface
<br/>
URL: https://127.0.0.1:9392
<br/>

:: Remove GVM

```powershell
sudo apt autoremove openvas*
```
```powershell
sudo apt-get remove --purge openvas*
```
```powershell
sudo apt-get remove --purge openvas9*
```
```powershell
sudo apt-get remove --purge openvas*
```
```powershell
sudo apt-get remove --purge libopenvas9
```
```powershell
sudo apt-get remove --purge libopenvas9-dev
```
```powershell
sudo apt autoremove
```
```powershell
sudo rm -rf /var/lib/openvas/
```
```powershell
sudo rm -rf /var/log/gvm/
```
```powershell
sudo rm -rf /var/lib/gvm/
```

<br/><br/><br/>

## Install HTOP interactive process viewer:

:: Install HTOP and suggested packages
```powershell
sudo apt-get install htop 
```
```powershell
sudo apt-get install lm-sensors 
```
```powershell
sudo apt-get install strace
```
```powershell
sudo apt-get install fancontrol
```

<br/>

:: To Exit HTOP
```powershell
control-z
```

<br/><br/><br/>

## Install Python:

:: Install
Look into installing the latest version


<br/><br/><br/>

## Install Java:

:: Install
```powershell
sudo apt install default-jdk
```

<br/><br/><br/>


## Install VLC Media Player:

:: Install
```powershell
sudo apt install vlc
```


<br/><br/><br/>


## Install Lee Barid Discover Script (Automates several passive and active penetration testing tasks):

:: Source
https://alphacybersecurity.tech/how-to-install-tools-to-kali-linux/
<br/><br/>
:: Install
This will be installed in the root of the user folder
<br/><br/>

#### -- Install and run as root --

```
sudo apt-get update && sudo apt-get upgrade
```
```
sudo git clone https://github.com/leebaird/discover.git
```
<br/><br/>
:: Run
```
cd discover
```
```
./update.sh
```
```
./discover.sh
```


<br/><br/><br/>

## Install Google Chrome:

:: Install
Follow Google’s instructions on the web.
```powershell
sudo apt update
```
```powershell
cd ~/Downloads
```
```powershell
sudo wget  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```
```powershell
sudo dpkg -i google-chrome-stable_current_amd64.deb
```
```powershell
google-chrome
```
<br/><br/>
:: Reset Google Chrome
```powershell
rm -rvf ~/. Config/google-chorme
```
<br/>

If we are nervous about removing a directory, use the mv command to create a backup:
```powershell
mv ~/.config/google-chrome/ ~/.config/google-chrome-bak/
```

<br/><br/>
:: Updating Google Chrome on Kali Linux
When we install Google Chrome on Kali, the official chrome repository will be added to our `/etc/apt/sources.list.d/ `directory.
<br/><br/>
With the help of the following command, we can verify its contents:
```powershell
cat /etc/apt/sources.list.d/google-chrome.list 
```
<br/>
As a result, Google Chrome will be updated whenever we update Kali’s system packages.

Still, if we want to update Chrome manually, we can do so using the following command:

```powershell
sudo apt upgrade google-chrome-stable
```

<br/><br/>
:: Uninstall Google Chrome Browser
If we need to uninstall Google chrome for any reason, then we have to open the terminal and type:

```powershell
dpkg -list | grep google
```
<br/>
We will see the Google Chrome package, which is currently installed on our system.
<br/>

Now, in order to uninstall Chrome on Kali, we need to use “apt-purge remove” to remove the Google Chrome package.
<br/>
```powershell
sudo apt -purge remove google-chrome-stable
```

The above command will uninstall Chrome from Kali.
<br/><br/><br/>
We can check again whether it has been removed or not by using the dpkg command:

```powershell
dpkg -list | grep google
```



<br/><br/><br/>

## Install Daniel Miessler’s SecLists (One of the more popular wordlists)

:: Source
https://alphacybersecurity.tech/how-to-install-tools-to-kali-linux/
<br/><br/>
:: Install
```powershell
sudo apt-get update && apt-get upgrade
```
```powershell
sudo git clone https://github.com/danielmiessler/SecLists.git /usr/share/wordlists/seclists
```
<br/>
or 
<br/><br/>


```powershell
sudo apt -y install seclists
```
<br/><br/>
:: File Location
```powershell
/usr/share/wordlists/seclists
```

<br/><br/><br/>


## Install: Seahorse (Password & Key Manager)

:: Install
```powershell
sudo apt-get install seahorse -y
```

<br/><br/><br/>

## Install: tilix (Multiplexer)

:: Install
```powershell
sudo apt-get install tilix -y
```

<br/><br/><br/>


## Create another SUDO user:

:: Add new user “<New User Name / New User Password>”
```powershell
sudo adduser <New User Name>
```
<br/>

:: Add new user to the sudo group.
```powershell
sudo usermod -a -G sudo <New User Name>
```
<br/>

:: Test new user
```powershell
su <New User Name>
```
<br/><br/><br/>

## Install Macbook Fan Daemon

mbpfan is a daemon that uses input from coretemp module and sets the fan speed using the applesmc module.
This enhanced version assumes any number of processors and fans (max. 10).

* It only uses the temperatures from the processors as input.
* It requires coretemp and applesmc kernel modules to be loaded.
* It requires root use
* It daemonizes or stays in foreground
* Verbose mode for both syslog and stdout
* Users can configure it using the file /etc/mbpfan.conf
<br/><br/>

:: Requirements

Be sure to load the kernel modules **applesmc** and **coretemp**.

These modules are often automatically loaded when booting up GNU/Linux on a MacBook. If that is not the case, you should make sure to load them at system startup.

**How do I know if applesmc and coretemp are loaded?**

In most distributions, you can run the following command:

```bash
lsmod | grep -e applesmc -e coretemp
```

If you see `coretemp` and `applesmc` listed, you are all set.

**If you do not see `coretemp` and `applesmc` listed, you must load them.**

This is _usually_ achieved by inserting the following two lines in the file `/etc/modules`

```powershell
coretemp
applesmc
```
<br/><br/>

:: Installation

```powershell
sudo apt-get install mbpfan
```
<br/><br/>
:: Run Instructions
<br/><br/>
If not installed, run with

   `sudo bin/mbpfan`
<br/><br/>
If installed, manually run with

`sudo mbpfan`
<br/><br/>
If installed and using the init file, run with (Ubuntu example)

`sudo service mbpfan start`

<br/><br/>

:: Starting at boot

An init file suitable for /lib/lsb/init-functions (Debian)
is located in the main folder of the source files, called mbpfan.init.debian
Rename it to mbpfan, give it execution permissions (chmod +x mbpfan)
and move it to /etc/init.d
Then, add it to the default runlevels with (as root):

`sudo update-rc.d mbpfan defaults`

<br/><br/><br/>

##


#HomeLab/Kali


RKHunter (Run this to update rkhunter) after system updates
rkhunter --propupd

