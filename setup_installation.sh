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
    printf >&2 "(WARNNING): $*"
}

_err () {
    printf >&2 "(ERROR): $*"
    exit 1
}

# Install Java 11 with reference https://www.fosstechnix.com/install-oracle-java-11-on-ubuntu/
install_java () {
    local _java_version=$1
    _log "Installing" "Java" $_java_version
    printf "Please make sure Java binary is installed in Downloads folder..\n"
    _is_binary_installed=$(ls /home/$USER_NAME/Downloads | grep ^jdk-[0-9]*.*.tar.gz$)
    if [ $? -ge 1 ]; then
        _err "The jdk binary is not installed..\n""You can install it from here: https://www.oracle.com/java/technologies/javase-jdk11-downloads.html\n"
    fi
    printf "sudo mkdir -p /opt/jdk; \ 
            cp -rf /home/$USER_NAME/$_is_binary_installed /opt/jdk; \
            tar -zxf /opt/jdk/$_is_binary_installed"
    _untared_jdk=$(ls | grep ^jdk-[0-9]*.[0-9].[0-9]$)
    printf "sudo update-alternatives --install /usr/bin/java java /opt/jdk/$_untared_jdk/bin/java 100; \
            update-alternatives --display java; \
            update-alternatives --config java; \
            bash -c 'echo JAVA_HOME=/opt/jdk/$_untared_jdk> /etc/environment'; \
            apt-get update;"
}

install_jenkins () {
    local _jenkins_version=$1
    _log "Installing" "Jenkins" $_jenkins_version
}

install_docker () {
    local _docker_version=$1
    _log "Installing" "Docker" $_docker_version
}

install_vmware () {
    local _vmware_version=$1
    _log "Installing" "VMware" $_vmware_version
}

setup_minikube_vmware () {
    _log "Setting up" "VMware" $_vmware_version
}

install_java