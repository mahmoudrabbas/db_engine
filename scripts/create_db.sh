#!/bin/bash

DB_DIR="$1"

if [[ ! -d "$DB_DIR" ]]; then
    echo -e "\033[31mDatabase directory doesnt exist\033[0m"
    exit 1
fi

while true; do
    echo -e "\033[34mEnter Database Name To Create:\033[0m"
    read -r db_name
    echo "------------------------------"

    if [[ -z "$db_name" ]]; then
        echo -e "\033[31mDatabase name cannot be empty\033[0m"
        continue
    fi

    if [[ ! "$db_name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
        echo -e "\033[31mInvalid name\033[0m"
        continue
    fi

    shopt -s nocaseglob

    if [[ -d "$DB_DIR/$db_name" ]]; then
        echo -e "\033[31mSorry, Database already exists\033[0m"
        shopt -u nocaseglob
        continue
    fi

    shopt -u nocaseglob

    mkdir "$DB_DIR/$db_name"
    echo -e "\033[35mDatabase <$db_name> created successfully\033[0m"
    exit 0
done
