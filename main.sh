#!/bin/bash

 
    # This is the main file of this simple app which is basically, to install the needed deps and softwares to automate the process of installing the needed deps/languages 
    # I usually use everytime I change my OS of any Linux Debian based distrbution.

_welcome="
    Welcome to my simple script software installer which is for installing software depencies and softwares that you might frequently need to install
    Author: AYMAN SOLIMAN
"

_usage="
    main.sh [options] <software>/<dependency>
"
_options="
    -G                 Install Golang stable version.
    -J                 Install Java 11.0.1
    -P3                Install Python3 and pip for python3 version
    -D                 Install Docker
    -j                 install jenkins
    -K                 Install Kubectl
    -M                 Install Minikube 
    -V                 Install VirtualBox
    -h | --help        Help for the usage
"


main () {
    echo "main handler"
}