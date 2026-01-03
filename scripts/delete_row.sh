#!/bin/bash

echo "Hello from deleting row"

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo "No tables found"
    exit 0
fi

PS3="Select table to delete row from: "
select tbl in "${tables[@]}"; do
    if [[ -z "$tbl" ]]; then
        echo "Invalid choice"
    else
        break
    fi
done

num_rows=$(wc -l < "$tbl")
if [[ $num_rows -le 1 ]]; then
    echo "Table is empty, nothing to delete"
    exit 0
fi

echo "---------------------------"
awk -F":" 'NR==1 {next} {printf "%d) ", NR-1; for(i=1;i<=NF;i++) printf "%-15s",$i; print ""}' "$tbl"
echo "---------------------------"

while true; do
    read -p "Enter the row number to delete: " row_num
    if [[ ! $row_num =~ ^[0-9]+$ ]] || (( row_num < 1 )) || (( row_num >= num_rows )); then
        echo "Invalid row number, try again"
    else
        break
    fi
done

# delete roe
# - NR==row_num+1 because NR counts from 1 and includes header
awk -v del="$((row_num+1))" 'NR!=del {print}' "$tbl" > tmpfile && mv tmpfile "$tbl"

