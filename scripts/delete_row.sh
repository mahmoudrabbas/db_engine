#!/bin/bash

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo "No tables found"
    exit 0
fi

PS3="Select table to delete row from: "
select tbl in "${tables[@]}"; do
    [[ -n "$tbl" ]] && break
    echo "Invalid choice"
done

data_count=$(awk 'NR>1 && NF>0' "$tbl" | wc -l)

if [[ $data_count -eq 0 ]]; then
    echo "Table is empty, nothing to delete"
    exit 0
fi

echo "---------------------------"
awk -F":" '
NR==1 { next }
NF>0 {
    printf "%d) ", ++i
    for (j=1; j<=NF; j++)
        printf "%-15s", $j
    print ""
}
' "$tbl"
echo "---------------------------"

while true; do
    read -p "Enter the row number to delete: " row_num
    if [[ $row_num =~ ^[0-9]+$ ]] && (( row_num >= 1 && row_num <= data_count )); then
        break
    fi
    echo "Invalid row number, try again"
done

awk -v del="$row_num" '
NR==1 { print; next }
NF>0 { count++ }
count != del { print }
' "$tbl" > tmpfile && mv tmpfile "$tbl"

echo "Row $row_num deleted successfully"
