#!/bin/bash


DB_DIR="$1"

PS3="type the db number to drop:"

if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi

arr=()
for db in "$DB_DIR"/*; do
    [[ -d "$db" ]] && arr+=("${db##*/}")
done

if [[ ${#arr[@]} -eq 0 ]]; then
    echo "no db to drop"
    exit 0
fi

select choice in "${arr[@]}"
do
    if [[ -z "$choice" ]]; then
        echo "$REPLY not on the menu"
        continue
    fi
    rm -r "$DB_DIR/$choice"
    echo "Datatabase $choice deleted successfully"
    break

done
