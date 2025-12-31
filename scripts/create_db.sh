#!/bin/bash

DB_DIR="$1"

if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi


echo "enter database name:"
read -r db_name

if [[ -z "$db_name" ]]; then
    echo "Database name cannot be empty"
    exit 1
fi

if [[ ! "$db_name" =~ ^[a-zA-Z][a-zA-Z0-9_]*$ ]]; then
    echo "invalid name"
    exit 1
fi


if [[ -d "$DB_DIR/$db_name" ]]; then
    echo "Database already exists"
    exit 1
fi

mkdir "$DB_DIR/$db_name"
echo "Database $db_name created successfully"

