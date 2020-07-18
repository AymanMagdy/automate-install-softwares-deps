#!/bin/bash

:'
    This file is to install and configure Java 11.0.1
    Install Python3 with reference https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/
'

install_python () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files."

    python3 --version >& /dev/null
    # Checking if python installed on the machine.
    if [ $? -ge 1 ]; then
        _log "Installing" "Go"
        _log "Updating" "local machine"
        sudo apt update
        _log "Installing" "deps"
        sudo apt install software-properties-common
        _log "Adding" "key to the local machine"
        echo -ne '\n' | sudo add-apt-repository ppa:deadsnakes/ppa
        _log "Installing" "Python" "3.8"
        sudo apt install python3.8
        python3.8 --version
        _log "Installing" "pip"
        sudo apt install python3-pip 
    else
        _warn "Python is already installed.."
        _log "Check up" "Python3" "Already installed."
        python3 --version
    fi
}