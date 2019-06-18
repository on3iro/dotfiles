#!/bin/bash

# abort on premature error
set -e

helpFunction()
{
   echo ""
   echo "Usage: $0 -n Name -t target"
   echo -e "\t-n File name to be appended"
   echo -e "\t-t Target Path"
   exit 1 # Exit script after printing help
}

TODAY=$(date +%Y-%m-%d)

while getopts :n:t: option
do
  case "${option}" in
    n ) NAME=${OPTARG};;
    t ) TARGET=${OPTARG};;
    ? ) helpFunction ;; # Print help function in case flag is not available
  esac
done

# Print helpFunction in case parameters are empty
if [ -z "$NAME" ]
then
   echo "Name parameter has to be set";
   helpFunction
fi

# Create file
if [ -n "$TARGET" ]
  then
    FILENAME="${TARGET}/${TODAY}_${NAME}.md"
  else
    FILENAME="${HOME}/tmp/${TODAY}_${NAME}.md"
fi

echo "Creating file $FILENAME"
touch $FILENAME
