#!/bin/bash

:'
    This file is to install and configure minikube the latest version.
    Install minikube latest version with reference https://phoenixnap.com/kb/install-minikube-on-ubuntu
'

install_minikube () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files."

    minikube version >& /dev/null
    _is_minikube_installed=$?
    
    if [ $_is_minikube_installed -ge 1 ]; then
        _log "Installing" "kubectl"
        cd $USERNAME
        wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
        sudo cp minikube-linux-amd64 /usr/local/bin/minikube; \
        sudo chmod 755 /usr/local/bin/minikube
        _log "Installed" "minikube"
        minikube version
        exit 0
    else 
        _warn "minikube is already installed.."
        _log "Check up" "minikube" "Already installed."
        go version
        exit 1
    fi
}