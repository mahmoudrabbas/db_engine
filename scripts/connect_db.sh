#!/bin/bash

DB_DIR="$1"
#SCRIPTS_DIR="$2"
if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi


PS3="Select DB to connect: "

arr=()
for db in "$DB_DIR"/*; do
    [[ -d "$db" ]] && arr+=("${db##*/}")
done

select choice in ${arr[@]}
do
    if [ $REPLY -gt ${#arr[@]} ]; then
        echo "$REPLY is not not the menu"
        continue
    else
        cd $DB_DIR/${arr[${REPLY}-1]}
        echo "connected to ${arr[${REPLY}-1]} Database"
        break
    fi
done



PS3="Select from table menu: "
select choice in "Create table" "List table" "Drop table" "Insert row" "Show data" "Delete row" "Update cell" "Exit"
do
    case $choice in
    "Create table" )
        echo "creating table"
        "../../scripts/create_table.sh"
        ;;
    "List table" )
        echo "Listing table"
        "../..//list_table.sh"
        ;;
    "Drop table" )
        echo "Drop table"
        "../..//drop_table.sh"
        ;;
    "Insert row" )
        echo "Inserting row"
        "../../insert_row.sh"
        ;;
    "Show data" )
        echo "Showing data"
        "$../../show_data.sh"
        ;;
    "Delete row" )
        echo "Deleting row"
        "../../delete_row.sh"
        ;;
    "Update cell" )
        echo "Updating cell"
        "../../update_cell.sh"
        ;;
    "Exit" )
        exit 1
        ;;
    * )
        echo "invalid choice"
        ;;
    esac
done




cd - &>/dev/null
