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
    echo >&2 "(WARNNING): $*"
}

_err () {
    echo >&2 "(ERROR): $*"
    exit 1
}

install_java () {
    local _java_version=$1
    _log "Installing" "Java" $_java_version
    printf "Please make sure Java binary is installed in Downloads folder.."
    if [ -z $USER_NAME ]; then
        _err "${FUNCNAME[0]}: Username is not provided.."
    fi
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