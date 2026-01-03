#!/bin/bash


DB_DIR="$1"


if [[ ! -d "$DB_DIR" ]]; then
    echo -e "\033[31mDatabase directory doesnt exist\033[0m"
    exit 1
fi

arr=()
for db in "$DB_DIR"/*; do
    [[ -d "$db" ]] && arr+=("$(basename "$db")")
done

if [[ ${#arr[@]} -eq 0 ]]; then
    echo -e "\033[31mNo databases to drop\033[0m"
    exit 0
fi

PS3=$'------------------------------\n\033[31mType Database Number To Drop: \033[0m'

select choice in "${arr[@]}"
do
    if [[ -z "$choice" ]]; then
        echo "$REPLY Not On The Menu"
        continue
    fi
    rm -r "$DB_DIR/$choice"
    echo "Datatabase $choice deleted successfully"
    break

done
