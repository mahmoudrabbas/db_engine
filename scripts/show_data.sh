#!/bin/bash

# echo "Hello from showing data"

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo "No tables found"
    exit 0
fi


PS3=$'------------------------------\n\033[34mSelect table to show data: \033[0m'
select tbl in "${tables[@]}"; do
    if [[ -z "$tbl" ]]; then
        echo "Invalid choice"
    else
        break
    fi
done

header=$(awk 'NR==1 {print}' "$tbl")

IFS=":" read -ra cols <<< "$header"


echo "------------------------------"
for ((i=0; i<${#cols[@]}; i+=2)); do
    printf "%-13s |" "${cols[i]}"
done
echo
echo "------------------------------"


tail -n +2 "$tbl" | while IFS=":" read -ra row; do
    for((i=0; i<${#row[@]}; i++))
        do
            printf "%-13s |" "${row[i]}"
        done
        echo
    done