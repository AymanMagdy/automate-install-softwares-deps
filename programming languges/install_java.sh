#!/bin/bash

:'
    This file is to install and configure Java 11.0.1
    Install Java 11 with reference https://www.fosstechnix.com/install-oracle-java-11-on-ubuntu/
'

install_java () {
    source ./../sys\ out/error.sh
    source ./../sys\ out/logs.sh
    source ./../sys\ out/warn.sh
    _log "Sourced the needed files, securely.."

    # Checking if Java installed on the machine.
    java --version >& /dev/null
    if [ $? -ge 1 ]; then
        _log "Installing" "Java"
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
             bash -c 'echo JAVA_HOME=/opt/jdk/$_untared_jdk>> /etc/environment'; \
             apt-get update -y; \ 
             _log "Installed Java.."
             java --version
    else
        _warn "Java is already installed.."
        _log "Check up" "Java" "Already installed."
        java --version
    fi
}

