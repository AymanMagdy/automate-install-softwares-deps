#!/bin/bash

:'
    This file is to install and configure virtualbox.
    Install virtualbox latest version with reference https://phoenixnap.com/kb/install-virtualbox-on-ubuntu
'

install_virualBox () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files."

    vboxmanage --version >& /dev/null
    _is_virtualBox_installed=$?

    if [ $_is_virtualBox_installed -ge 1 ]; then
        _log "Adding" "VirtualBox repo"
        wget https://download.virtualbox.org/virtualbox/6.1.12/virtualbox-6.1_6.1.12-139181~Ubuntu~bionic_amd64.deb
        echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian <mydist> contrib" >> /etc/apt/sources.list
        
        _log "Adding" "VirtualBox keys"
        sudo apt-key add oracle_vbox_2016.asc
        sudo apt-key add oracle_vbox.asc

        _log "Updating the system and Downloading" "VirtualBox "
        sudo apt-get update -y
        sudo apt-get install virtualbox-6.1 -y

        _log "Installed" "VirtualBox"
        vboxmanage --version
        exit 0
    else
        _warn "VirtualBox is already installed.."
        _log "Check up" "VirtualBox" "Already installed."
        vboxmanage --version
        exit 1
    fi 
}