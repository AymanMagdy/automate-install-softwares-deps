#!/bin/bash

#     This file is to print the error to the user.

_err () {
    printf >&2 "(ERROR): $*\n"
    exit 1
}