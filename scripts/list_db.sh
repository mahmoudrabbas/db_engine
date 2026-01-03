#!/bin/bash

DB_DIR="$1"

if [[ ! -d "$DB_DIR" ]]; then
    echo -e "\033[31mDatabase directory doesnt exist\033[0m"
    exit 1
fi


echo "------------------------------"
echo "---- Existed Datatabases -----"
shopt -s nullglob

db_list=("$DB_DIR"/*)

# echo ${#db_list[@]}

if [[ ${#db_list[@]} -eq 0 ]]; then
    echo -e "\033[31mNo databases to show\033[0m"
    # echo "------------------------------"
else
    ls -1 "$DB_DIR" | awk '{print NR") " $0}'
fi

# echo "------------------------------"


exit 0