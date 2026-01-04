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
    echo -e "\033[31mInvalid choice, try again!\033[0m"
    continue
    ;;
    *)
        if [[ ! -f $t ]]
        then 
            echo -e "\033[31mSorry, Table doesnt exist\033[0m"
            continue
        else
            rm "$t"
            echo -e "\033[34mTable '$t' deleted\033[0m"
            break
        fi
    esac
done