#!/bin/bash

:'
    This file is to print the warnning to the user.
'

_warn () {
    printf >&2 "(WARNNING): $*\n"
}