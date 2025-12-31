#!/bin/bash

DB_DIR="$1"

if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi


echo "===Datatabases===="
shopt -s nullglob

db_list=("$DB_DIR"/*)

#echo ${#db_list[@]}

if [[ ${#db_list[@]} -eq 0 ]]; then
    echo "no databases to show"
else
    ls -1 "$DB_DIR"
fi
exit 0