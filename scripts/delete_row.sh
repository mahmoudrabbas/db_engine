#!/bin/bash

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo -e "\033[31mNo tables found\033[0m"
    exit 0
fi

PS3=$'------------------------------\n\033[32mSelect table to delete row from: \033[0m'
select tbl in "${tables[@]}"; do
    [[ -n "$tbl" ]] && break
    echo -e "\033[31mInvalid choice\033[0m"
done

data_count=$(awk 'NR>1 && NF>0' "$tbl" | wc -l)

if [[ $data_count -eq 0 ]]; then
    echo -e "\033[31mTable is empty, nothing to delete\033[0m"
    exit 0
fi

echo "---------------------------"

awk -F":" '
NR==1 {
    # Header
    printf "%-5s|%-15s|%-15s\n", "pk", "id", "name"
    print "---------------------------"
    next
}
NR>1 && NF>1 {
    printf "%-5d|%-15s|%-15s\n", ++i, $1, $2
}
' "$tbl"

echo "---------------------------"

while true; do
    read -p "Enter the row number to delete: " row_num

    if [[ ! $row_num =~ ^[0-9]+$ ]]; then
        echo -e "\033[31mInvalid row number, try again\033[0m"
        continue
    fi

    if (( row_num < 1 || row_num > data_count )); then
        echo -e "\033[31mRow Doesn't Exist, try again\033[0m"
        continue
    fi

    break
done

awk -v del="$row_num" '
NR==1 { print; next }
NF>0 { count++ }
count != del { print }
' "$tbl" > tmpfile && mv tmpfile "$tbl"

echo -e "\033[35mRow $row_num deleted successfully\033[0m"
