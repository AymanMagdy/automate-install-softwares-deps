#!/bin/bash

#     This file is to install and configure jenkins.
#     Install jenkins latest version with reference https://www.jenkins.io/doc/book/installing/

install_jenkins () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced" "the needed files"

    java --version >& /dev/null
    _is_java_installed=$?

    head -5  /var/lib/jenkins/config.xml | grep -oP '(?<=<version>).*?(?=</version>)' >& /dev/null
    _is_jenkins_installed=$?
 
    if [ $_is_java_installed -eq 0 -a $_is_jenkins_installed -eq 0 ]; then
        _log "Adding" "Repo"
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
        sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

        _log "Updating" "local machine"
        apt update -y;
        
        _log "Installing" "jenkins"
        apt install jenkins -y
        
        _log "Starting" "jenkins"
        sudo systemctl start jenkins

        _log "Jenkins" "status"
        sudo systemctl status jenkins
        exit 0
    elif ! [ $_is_java_installed -eq 0 ]
        _log "Java is not installed"
    else
        _warn "jenkins is already installed.."
        _log "Check up" "jenkins" "Already installed."
        echo "Version:" 
        head -5  /var/lib/jenkins/config.xml | grep -oP '(?<=<version>).*?(?=</version>)'
        _log "Run" "sudo systemctl start jenkins.service"
        exit 1
    fi
}