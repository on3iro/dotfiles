#!/bin/bash

# abort on premature error
set -e

helpFunction()
{
   echo "Creates a random string"
   echo "Usage: $0 -n Length"
   echo -e "\t-l Length"
   echo -h "\t-h Help"
   exit 1 # Exit script after printing help
}

while getopts l:h: option
do
  case "${option}" in
    l ) LENGTH=${OPTARG};;
    h ) helpFunction ;;
    ? ) helpFunction ;; # Print help function in case flag is not available
  esac
done

# Set length
if [ -n "$LENGTH" ]
  then
    PWLENGTH=${LENGTH}
  else
    PWLENGTH=24
fi

cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w $PWLENGTH | head -n 1
