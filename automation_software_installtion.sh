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
            apt-get update -y; \ 
            java -version
    else
        _warn "Java is already installed."
        _log "Check up" "Java" "Already installed."
        java -version
    fi
}

# Installing jenkins
install_jenkins () {
    local _jenkins_version=$1
    _log "Installing" "Jenkins" $_jenkins_version

    _is_java_installed=$(java -version)
    if [ $? -ge 1]; then
        _err "Java is not installed""Please install java."
    else
        _log "Adding The key and jenkins repo"
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
        sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

        _log "Updating and installing jenkins"
        apt update;\
        apt install jenkins -y
        
        _log "Starting the jenkins"
        systemctl start jenkins

        _log "Jenkins status: "
        systemctl status jenkins
    fi 
}

# Installig docker (Container runtime engine.).
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

        _log "Adding the docker group"
        sudo groupadd docker
        sudo gpasswd -a $USER docker
    else 
        _warn "Docker is already installed."
        _log "Check up" "Docker" "Already installed."
        docker version
   fi
}

# installing VirtualBox
install_virtualBox () {
    local _virtualbox_version=$1
    _log "Installing" "VirtualBox" $_virtualbox_version

    _log "Installing" "VirtualBox dependencies"
    sudo apt-get install apt-transport-https; \
         apt -y install virtualbox virtualbox-ext-pack
}

# installing minikube cluster
install_minikube () {
    local _virtualbox_version=$1
    _log "Installing" "VirtualBox" $_virtualbox_version
    cd $USER_NAME
    wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo cp minikube-linux-amd64 /usr/local/bin/minikube; \
    sudo chmod 755 /usr/local/bin/minikube
    # To ensure the user the minikube has been installed.
    minikube version
}

# install kubectl
install_kubectl () {
    local _kubectl_version=$1
    _log "Installing" "kubectl" $_kubectl_version
    curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
    sudo chmod +x ./kubectl

    # To ensure the user the kubectl is installed
    kubectl version -o json
}

# Install python3.8
install_python () {
    local _python_version=$1
    _log "Check up" "Python version" $_python_version
    printf "Updating the system...\n"
    sudo apt update
    printf "Installing deps..\n"
    sudo apt install software-properties-common
    printf "Adding the repo to the machine..\n"
    echo -ne '\n' | sudo add-apt-repository ppa:deadsnakes/ppa
    printf "Installing python3.8.."
    sudo apt install python3.8
    python3.8 --version
}


install_python "3.8.0"