#!/bin/bash

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo -e "\033[31mNo tables to insert into\033[0m"
    exit 0
fi


PS3=$'------------------------------\033[31m\nSelect table to insert into: \033[0m'
select tbl in "${tables[@]}"
do
    if [[ -z "$tbl" ]]; then
        echo "Invalid choice"
    else
        break
    fi
done


header=$(awk 'NR==1 {print}' "$tbl")

IFS=":" read -ra cols <<< "$header"

row=""

for ((i=0; i<${#cols[@]}; i+=2)); do
    column_name="${cols[i]}"
    column_type="${cols[i+1]}"

    while true; do
        read -p "Enter $column_type value for $column_name: " value

        if [[ "$column_type" == "integer" ]]; then
            [[ "$value" =~ ^[0-9]+$ ]] && break
            echo "Invalid integer value"
        else
            [[ "$value" =~ ^[a-zA-Z]+$ ]] && break
            echo "String must contain letters only"
        fi
    done

    row+="$value:"
done

echo "$row" >> "$tbl"
echo -e "\033[35mRow inserted successfully\033[0m"
