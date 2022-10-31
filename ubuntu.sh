#!/usr/bin/env bash

# Typography
green=$(tput setaf 2)
lila=$(tput setaf 4)
blue=$(tput setaf 6)

bold=$(tput bold)
reset=$(tput sgr0)

heading ()
{
    echo "    ${lila}==>${reset}${bold} $1${reset}"
}
success ()
{
    echo "    ${green}==>${reset}${bold} $1${reset}"
}
info ()
{
    echo "    ${blue}==>${reset}${bold} $1${reset}"
}

heading "Installing system dependencies..."
apt update
apt upgrade -y
apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release
success "Installed system dependencies..."

info "Installing ufw..."
apt install ufw
ufw default deny
ufw allow 2212/tcp
ufw enable
success "Installed ufw..."

info "Installing docker and docker dompose..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
success "Installed docker and docker dompose..."