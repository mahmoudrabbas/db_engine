#!/bin/bash

echo "Hello from creating table"
echo "Already existing tables"
ls

#table name
while true; do
    read -p "Enter your table name to create: " table_name

    case "$table_name" in
        "")
            echo "Name can't be empty"
            ;;
        *[[:space:]]*)
            echo "Table name can't contain spaces"
            ;;
        [0-9]*)
            echo "Table name can't start with a digit"
            ;;
        *[^a-zA-Z_]*)
            echo "Table name can only contain letters and underscore"
            ;;
        *)
            if [[ -e "$table_name" ]]; then
                echo "Table already exists"
            else
                touch "$table_name"
                echo "Table created successfully"
                break
            fi
            ;;
    esac
done

#//number of fields
while true; do
    read -p "Insert num of fields for $table_name table: " fields_num

    case "$fields_num" in
        ''|*[!0-9]*)
            echo "Invalid number"
            ;;
        0)
            echo "Field number can't be zero"
            ;;
        *)
            echo "Fields number is $fields_num"
            break
            ;;
    esac
done

#columns
row_name=""

for ((i=1; i<=fields_num; i++)); do
    while true; do
        read -p "Enter name of column No. $i: " column_name

        case "$column_name" in
            "")
                echo "Name can't be empty"
                ;;
            *[[:space:]]*)
                echo "Name can't contain spaces"
                ;;
            [0-9]*)
                echo "Name can't start with numbers"
                ;;
            ^[a-zA-Z_][a-zA-Z0-9_]*$)
                echo "Invalid column name"
                ;;
            *)
                if echo "$row_name" | grep -w "$column_name" &>/dev/null; then
                    echo "Column already exists"
                else
                    break
                fi
                ;;
        esac
    done

    PS3="Enter type of column $column_name: "
    select choice in integer string
        do
        case "$choice" in
            "integer" )
                break
                ;;
            "string" )
                break
                    ;;
            * )
                echo "Invalid type, only 'integer' or 'string' allowed"
                ;;
        esac
    done

    row_name+="$column_name:$choice:"
done


echo "$row_name" >> "$table_name"
echo "Table data is created successfully"
