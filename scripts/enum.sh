#!/bin/bash

# Argument/Error Handling Section
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [ $# -eq 0 ] || [ -z "$1" ];
  then
    echo "No arguments supplied. i.e. ./enum.sh [IP ADDRESS]"
fi

if [ $# -gt 1 ];
  then
    echo "Extra arguments detected. i.e. ./enum.sh [IP ADDRESS]"
fi

whoami
