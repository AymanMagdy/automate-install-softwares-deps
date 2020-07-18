#!/bin/bash

:'
    This file is to install and configure Golang the latest version.
    Install go latest version with reference https://medium.com/better-programming/install-go-1-11-on-ubuntu-18-04-16-04-lts-8c098c503c5f.
'

# Install Go
# Refer here for the full installation guidance : https://medium.com/better-programming/install-go-1-11-on-ubuntu-18-04-16-04-lts-8c098c503c5f
install_GO () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files."

    go version >& /dev/null
    # Checking if Go installed on the machine.
    if [ $? -ge 1 ]; then
        _log "Installing" "Java"
        _log "Updating" "local machine"
        sudo apt-get update -y
        _log "installing" "Go"
        wget https://storage.googleapis.com/golang/getgo/installer_linux
        chmod 777 installer_linux
        ./installer_linux
        source /home/$USERNAME/.bash_profile
        go version
    else
        _warn "Go is already installed.."
        _log "Check up" "Go" "Already installed."
        go version
    fi
}