#!/bin/bash

# echo "Hello from updating cell"

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo -e "\n\033[32mNo tables found\n\033[32m"
    exit 0
fi

PS3=$'---------------------------\n\033[32mSelect table to update: \033[0m'
select tbl in "${tables[@]}"; do
    if [[ -z "$tbl" ]]; then
        echo -e "\n\033[31mInvalid choice\n\033[0m"
    else
        break
    fi
done

num_rows=$(wc -l < "$tbl")
if [[ $num_rows -le 1 ]]; then
    echo -e "\n\033[31mTable is empty, nothing to update\n\033[0m"
    exit 0
fi

header=$(awk 'NR==1 {print}' "$tbl")
IFS=":" read -ra cols <<< "$header"

echo "---------------------------"
awk -F":" 'NR==1 {next} {printf "%d) ", NR-1; for(i=1;i<=NF;i++) printf "%-15s",$i; print ""}' "$tbl"
echo "---------------------------"

while true; do
    read -p "Enter the row number to update: " row_num
    if [[ ! $row_num =~ ^[0-9]+$ ]] || (( row_num < 1 )) || (( row_num >= num_rows )); then
        echo -e "\n\033[32mInvalid row number, try again\n\033[0m"
    else
        break
    fi
done

echo "Columns:"
for ((i=0; i<${#cols[@]}; i+=2)); do
    echo "$((i/2+1))) ${cols[i]} (${cols[i+1]})"
done

while true; do
    read -p "Enter the column number to update: " col_num
    if [[ ! $col_num =~ ^[0-9]+$ ]] || (( col_num < 1 )) || (( col_num > ${#cols[@]}/2 )); then
        echo "Invalid column number, try again"
    else
        break
    fi
done

col_index=$(( (col_num-1)*2 ))
col_name="${cols[col_index]}"
col_type="${cols[col_index+1]}"

while true; do
    read -p "Enter new $col_type value for $col_name: " new_value
    if [[ "$col_type" == "integer" ]]; then
        [[ $new_value =~ ^[0-9]+$ ]] && break
        echo -e "\033[31mInvalid value: must be integer\033[0m"
    else
         [[ "$value" =~ ^[a-zA-Z]+$ ]] && break
        echo -e "\033[31mString must contain letters only\033[0m"
    fi
done

awk -F":" -v row="$((row_num+1))" -v col="$((col_index+1))" -v val="$new_value" '{
    if (NR==row) $col=val;
    print $0
}' OFS=":" "$tbl" > tmpfile && mv tmpfile "$tbl"

echo "\033[35mRow $row_num, column $col_name updated successfully\033[0m"