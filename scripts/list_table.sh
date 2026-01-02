#!/bin/bash

echo "Hello from listing table"

shopt -s nullglob

tables=(*)

count=0
echo "Tables in this database:"

for table in "${tables[@]}"; do
    if [[ -f "$table" ]]; then
        ((count++))
        echo "$count) $table"
    fi
done

if [[ $count -eq 0 ]]; then
    echo "No tables found in this database"
fi
