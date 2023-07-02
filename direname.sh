#!/bin/bash

TEMP=$PWD/tmp.txt

#-------------------------------COLOR------------------------#
YL='\033[1;33m'
GR='\033[0;32m'
RD='\033[0;31m'
PL='\033[0;35m'
NC='\033[0m' # No Color
#-------------------------------HELP-------------------------#
Help()
{
   # Display Help
   echo -e "Syntax: ${YL}direname${NC} [-o|n|h]"
   echo "options:"
   echo -e "-o     Old directory name, sample: ${PL}test${NC}"
   echo -e "-n     New directory name, default: ${PL}tets${NC}"
   echo "-h     Help!"
   echo
}
#------------------------------OPTIONS----------------------# 
while getopts o:n:h option
do
    case "${option}" in
        o) OLD_DIR=${OPTARG};;
        n) NEW_DIR=${OPTARG};;
        h) # display Help
         Help
         exit;;
    esac
done

if [ -z "$OLD_DIR" ] || [ -z "$NEW_DIR" ]
then
        echo -e  "[x] ERROR - ${RD}Folder name to search or replace is required.${NC}"
else
        find / -type d -name ${OLD_DIR} 2> /dev/null > $TEMP

        IFS=$'\n' read -d '' -r -a lines < $TEMP

        if [ -z "${lines[@]}" ]
        then
            echo -e "${YL}[!] Can't find a folder named: ${OLD_DIR}, Please try again!${NC}"
        else
            for line in "${lines[@]}"; do  # loop through the array
                result=$(echo "$line" | sed "s/$OLD_DIR/$NEW_DIR/g")

                mv "$line" "$result"

                echo -e "[+] DONE - Renamed ${YL}${line}${NC} to ${GR}${result}${NC}"
            done
        fi
        rm -f $TEMP
fi


# https://stackoverflow.com/questions/22009364/is-there-a-try-catch-command-in-bash
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
# https://stackoverflow.com/questions/52901012/what-is-a-list-in-bash