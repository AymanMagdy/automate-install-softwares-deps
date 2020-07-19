#!/bin/bash

:'
    This file is to install and configure kubectl.
    Install kubectl latest version with reference https://kubernetes.io/docs/tasks/tools/install-kubectl/
'

install_kubectl () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files."

    kubectl get --help >& /dev/null
    _is_kubectl_installed=$?
    
    if [ $_is_kubectl_installed -ge 1 ]; then
        _log "Installing" "kubectl" "The latest stable version."
        curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
        sudo chmod +x ./kubectl
        _log "Installed" "kubectl" "The latest stable version."
        kubectl version -o json
        exit 0
    else
        _warn "Kubectl is already installed.."
        _log "Check up" "Kubectl" "Already installed."
        kubectl version -o json
        exit 1
    fi
}