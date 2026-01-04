#!/bin/bash

shopt -s nullglob

tables=(*)

if [[ ${#tables[@]} -eq 0 ]]; then
    echo -e "\n\033[32mNo tables found\n\033[0m"
    exit 0
fi

PS3=$'---------------------------\n\033[32mSelect table to update: \033[0m'
select tbl in "${tables[@]}"; do
    if [[ -z "$tbl" ]]; then
        echo -e "\033[31mInvalid choice\033[0m"
    else
        break
    fi
done

num_rows=$(wc -l < "$tbl")
if (( num_rows <= 1 )); then
    echo -e "\n\033[31mTable is empty, nothing to update\033[0m"
    exit 0
fi

header=$(awk 'NR==1{print}' "$tbl")
IFS=":" read -ra cols <<< "$header"

echo -e "\n\033[32mCurrent table:\033[0m"
awk -F":" '
NR==1 {
    printf "%-5s|", "pk"
    for (i=1; i<=NF; i+=2)
        printf "%-15s|", $i
    print ""
    print "----------------------------------------"
    next
}
NR>1 && NF>1 {
    printf "%-5d|", NR-1
    for (i=1; i<=NF-1; i++)
        printf "%-15s|", $i
    print ""
}
' "$tbl"
echo "----------------------------------------"

while true; do
    read -p "Enter the row number to update: " row_num
    if [[ ! $row_num =~ ^[0-9]+$ ]] || (( row_num < 1 || row_num >= num_rows )); then
        echo -e "\033[31mInvalid row number, try again\033[0m"
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
    if [[ ! $col_num =~ ^[0-9]+$ ]] || (( col_num < 1 || col_num > ${#cols[@]}/2 )); then
        echo -e "\033[31mInvalid column number, try again\033[0m"
    else
        break
    fi
done

col_name="${cols[(col_num-1)*2]}"
col_type="${cols[(col_num-1)*2+1]}"

while true; do
    read -p "Enter new $col_type value for $col_name: " new_value
    if [[ "$col_type" == "integer" ]]; then
        [[ $new_value =~ ^[0-9]+$ ]] && break
        echo -e "\033[31mInvalid value: must be integer\033[0m"
    else
        [[ "$new_value" =~ ^[a-zA-Z]+([[:space:]][a-zA-Z]+)*$ ]] && break
        echo -e "\033[31mString must contain letters only\033[0m"
    fi
done

awk -F":" \
-v row="$((row_num+1))" \
-v col="$col_num" \
-v val="$new_value" '
NR==row {
    $col = val
}
{
    if ($NF != "")
        print $0 ":"
    else
        print $0
}
' OFS=":" "$tbl" > tmpfile && mv tmpfile "$tbl"

echo -e "\033[35mRow $row_num, column $col_name updated successfully\033[0m"

echo -e "\n\033[32mUpdated table:\033[0m"
awk -F":" '
NR==1 {
    printf "%-5s|", "pk"
    for (i=1; i<=NF; i+=2)
        printf "%-15s|", $i
    print ""
    print "----------------------------------------"
    next
}
NR>1 && NF>1 {
    printf "%-5d|", NR-1
    for (i=1; i<=NF-1; i++)
        printf "%-15s|", $i
    print ""
}
' "$tbl"
echo "----------------------------------------"
