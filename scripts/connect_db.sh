#!/bin/bash

DB_DIR="$1"

if [[ ! -d "$DB_DIR" ]]; then
    echo "Database directory doesnt exist"
    exit 1
fi


PS3=$'------------------------------\n\033[34mSelect Database to connect: \033[0m '

arr=()
for db in "$DB_DIR"/*; do
    [[ -d "$db" ]] && arr+=("${db##*/}")
done

if [[ ${#arr[@]} -eq 0 ]]; then
    echo "No databases found"
    exit 0
fi

select choice in "${arr[@]}"
do
    if ! [[ "$REPLY" =~ ^[0-9]+$ ]]; then
        echo -e "\033[31mPlease enter a valid number\033[0m"
        continue
    fi

    if (( REPLY < 1 || REPLY > ${#arr[@]} )); then
        echo -e "\033[31m$REPLY is not in the menu\033[0m"
        continue
    fi

    cd "$DB_DIR/${arr[REPLY-1]}" || exit 1
    echo -e "\033[35mConnected to ${arr[REPLY-1]} Database\033[0m"
    break
done


PS3=$'------------------------------\n\033[34mSelect from table menu: \033[0m '

select choice in \
"Create table" \
"List table" \
"Drop table" \
"Insert row" \
"Show data" \
"Delete row" \
"Update cell" \
"Exit"
do
    case "$REPLY" in
        1)
            echo "Creating Table"
            "../../scripts/create_table.sh"
            ;;
        2)
            echo "Listing Table"
            "../../scripts/list_table.sh"
            ;;
        3)
            echo "Drop Table"
            "../../scripts/drop_table.sh"
            ;;
        4)
            echo "Inserting Row"
            "../../scripts/insert_row.sh"
            ;;
        5)
            echo "Showing Data"
            "../../scripts/show_data.sh"
            ;;
        6)
            echo "Deleting Row"
            "../../scripts/delete_row.sh"
            ;;
        7)
            echo "Updating Cell"
            "../../scripts/update_cell.sh"
            ;;
        8)
            break
            ;;
        *)
            echo -e "\033[31mInvalid choice, enter a number from the menu\033[0m"
            ;;
    esac
done

cd - &>/dev/null
