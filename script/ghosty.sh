echo 'deb http://download.opensuse.org/repositories/home:/clayrisser:/sid/Debian_Unstable/ /' | sudo tee /etc/apt/sources.list.d/home:clayrisser:sid.list
curl -fsSL https://download.opensuse.org/repositories/home:clayrisser:sid/Debian_Unstable/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_clayrisser_sid.gpg >/dev/null
sudo apt update
sudo apt install ghostty
