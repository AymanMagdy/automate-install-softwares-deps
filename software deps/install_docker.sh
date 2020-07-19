#!/bin/bash

:'
    This file is to install and configure docker.
    Install docker latest version with reference  https://runnable.com/docker/install-docker-on-linux
'

install_docker () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files"

   docker --version >& /dev/null
   if [ $? -ge 1 ]; then 
        _log "Removing" "Docker" "If any deps installed."
        apt-get remove docker docker-engine docker.io containerd runc -y
        _log "Updating" "current system" 
        apt-get update -y

        _log "Install" "dependecies"
        sudo apt-get install -y \
             apt-transport-https \
             ca-certificates \
             curl \
             gnupg-agent \
             software-properties-common

        _log "Adding" "Docker key"
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        _log "Adding" "Docker repo"
        sudo add-apt-repository \
             "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
             $(lsb_release -cs) \
             stable"

        _log "Update" "System before installing"
        sudo apt-get update -y

        _log "Installing" "Docker engine"
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io

        _log "Adding" "the docker group"
        sudo groupadd docker
        sudo gpasswd -a $USER docker

        _log "Installed" "the docker group"
        docker --version
        exit 0
    else 
        _warn "Docker is already installed."
        _log "Check up" "Docker" "Already installed."
        docker --version
        exit 1
   fi
}