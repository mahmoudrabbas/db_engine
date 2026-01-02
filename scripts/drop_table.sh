#!/bin/bash

echo "Hello from dropping table"

# DB_DIR="$1"

shopt -s nullglob

tbls=("."/*)

if [[ ${#tbls[@]} -eq 0 ]]; then
    echo "No tables to drop"
    exit 0
fi


tables=()

for tbl in ${tbls[@]}
do
    [[ -f "$tbl" ]] && tables+=("$(basename "$tbl")")
done

PS3="Select table to drop: "
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
            echo "Table doesnt exist"
            continue
        else
            rm "$t"
            echo "Table '$t' deleted"
            break
        fi
    esac
done