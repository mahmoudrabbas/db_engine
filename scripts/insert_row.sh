#!/bin/bash

echo "Hello from inserting row"

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo "Not tables to insert in"
    exit 0
fi


PS3="Select table to insert into: "
select tbl in "${tables[@]}"
do
    if [[ -z "$tbl" ]]; then
        echo "Invalid choice"
    else
        break
    fi
done


header=$(awk 'NR==1 {print}' $tbl)

IFS=":" read -ra cols <<< "$header"

row=""

for ((i=0; i<${#cols[@]}; i+=2)); do
    column_name="${cols[i]}"
    column_type="${cols[i+1]}"

    while true; do
        read -p "Enter $column_type value for $column_name: " value

        if [[ "$column_type" == "integer" ]]; then
            [[ $value =~ ^[0-9]+$ ]] && break
            echo "Invalid value"
        else 
            [[ -n "$value" && $value =~  ]] && break
            echo "String cant be empty"
        fi
    done

    row+="$value:"

done

echo "$row" >> "$tbl"

echo "Row inserted successfully"