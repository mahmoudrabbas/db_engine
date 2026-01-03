#!/bin/bash

DB_DIR="$1"
#SCRIPTS_DIR="$2"
if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi


PS3=$'------------------------------\n\033[34mSelect Database to connect: \033[0m'

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
        echo -e "\033[35mConnected to ${arr[${REPLY}-1]} Database\033[0m"
        break
    fi
done



PS3=$'------------------------------\n\033[34mSelect from table menu: \033[0m'
select choice in "Create table" "List table" "Drop table" "Insert row" "Show data" "Delete row" "Update cell" "Exit"
do
    case $choice in
    "")
        echo -e "\033[31mChoose an operation to do!\033[0m "
        continue
        ;;
    "Create table" )
        echo "Creating Table"
        "../../scripts/create_table.sh"
        ;;
    "List table" )
        echo "Listing Table"
        "../../scripts/list_table.sh"
        ;;
    "Drop table" )
        echo "Drop Table"
        "../../scripts/drop_table.sh"
        ;;
    "Insert row" )
        echo "Inserting Row"
        "../../scripts/insert_row.sh"
        ;;
    "Show data" )
        echo "Showing Data"
        "../../scripts/show_data.sh"
        ;;
    "Delete row" )
        echo "Deleting Row"
        "../../scripts/delete_row.sh"
        ;;
    "Update cell" )
        echo "Updating Cell"
        "../../scripts/update_cell.sh"
        ;;
    "Exit" )
        exit 1
        ;;
    * )
        echo "Invalid Choice"
        ;;
    esac
done




cd - &>/dev/null
