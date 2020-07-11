#!/bin/bash

# This bash script is to install the basic required softwares and deps for my personal use.
# Make a pull request to add any required software/dep for your own usage.

: '
    For the naming convention, please take a look here -> https://github.com/icy/bash-coding-style
'

# Global vars
USER_NAME=$USERNAME


# Start of the functions:
_log () {
    local _operation_type=$1
    local _software_name=$2
    local _software_version=$3
    printf "(LOGGING) ${_operation_type} ${_software_name:-unknown}...\nVersion: ${_software_version:-No version}.\n"
}

_warn () {
    printf >&2 "(WARNNING): $*\n"
}

_err () {
    printf >&2 "(ERROR): $*\n"
    exit 1
}

# Install Java 11 with reference https://www.fosstechnix.com/install-oracle-java-11-on-ubuntu/
install_java () {
    local _java_version=$1
    _log "Installing" "Java" $_java_version
    _is_java_installed=$(java -version)
    if [ $? -ge 1 ]; then
        _log "Installing" "JDK" "11.0.1"
        cd /home/$USER_NAME; \
        curl -L -C - -b "oraclelicense=accept-securebackup-cookie" \
        -O http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.tar.gz

        _log "Installed" "JDK" "11.0.1"
        _log "Configuring" "JAVA_HOME..."

        _installed_java=$(ls /home/$USER_NAME | grep ^jdk-[0-9]*.*.tar.gz$)
        sudo mkdir -p /opt/jdk; \ 
            cp -rf /home/$USER_NAME/$_installed_java /opt/jdk; \
            tar -zxf /opt/jdk/$_installed_java
        _untared_jdk=$(ls | grep ^jdk-[0-9]*.[0-9].[0-9]$)
        sudo update-alternatives --install /usr/bin/java java /opt/jdk/$_untared_jdk/bin/java 100; \
            update-alternatives --display java; \
            update-alternatives --config java; \
            bash -c 'echo JAVA_HOME=/opt/jdk/$_untared_jdk> /etc/environment'; \
            apt-get update; \ 
            java -version
    else
        _warn "Java is already installed."
        _log "Check up" "Java" "Already installed."
        java -version
    fi
    
}

install_jenkins () {
    local _jenkins_version=$1
    _log "Installing" "Jenkins" $_jenkins_version
}

install_docker () {
    local _docker_version=$1
    _log "Installing" "Docker" $_docker_version

   _is_docker_installed=$(docker version)
   if [ $? -ge 1 ]; then 
         _log "Removing" "Docker" "If any deps installed."
        apt-get remove docker docker-engine docker.io containerd runc
        _log "Updating" "current system" 
        apt-get update -y

        _log "Install dependecies"
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
    else 
        _warn "Docker is already installed."
        _log "Check up" "Docker" "Already installed."
        docker version
   fi
}

install_vmware () {
    local _vmware_version=$1
    _log "Installing" "VMware" $_vmware_version
}

setup_minikube_vmware () {
    _log "Setting up" "VMware" $_vmware_version
}

install_docker