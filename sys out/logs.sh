#!/bin/bash

 #   This file is to print the logs to the user.

_log () {
    local _operation_type=$1
    local _software_name=$2
    local _software_version=$3
    printf "(LOGGING) ${_operation_type:-No operation detected.\n} ${_software_name:-No software detected.\n}...\nVersion: ${_software_version:-No version detected}.\n"
}