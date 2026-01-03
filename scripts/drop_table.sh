#!/bin/bash

# echo "Hello from dropping table"

# DB_DIR="$1"

shopt -s nullglob

tbls=("."/*)

if [[ ${#tbls[@]} -eq 0 ]]; then
    echo -e "\033[31mNo tables to drop\033[0m"
    exit 0
fi


tables=()

for tbl in ${tbls[@]}
do
    [[ -f "$tbl" ]] && tables+=("$(basename "$tbl")")
done

PS3=$'------------------------------\033[32m\nSelect table to drop: \033[0m'
select t in "${tables[@]}";
do
    case $t in
    "") 
    echo "Invalid choice, try again!"
    continue
    ;;
    *)
        if [[ ! -f $t ]]
        then 
            echo "Sorry, Table doesnt exist"
            continue
        else
            rm "$t"
            echo "Table '$t' deleted"
            break
        fi
    esac
done