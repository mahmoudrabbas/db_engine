#!/bin/bash

SCRIPTS_DIR="."
DB_DIR="../db"

PS3=$'------------------------------\033[33m\nChoose an option: \033[0m'

select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB EXIT
do
    case $choice in

    CREATE_DB )
        "$SCRIPTS_DIR/list_db.sh" "$DB_DIR"
        "$SCRIPTS_DIR/create_db.sh" "$DB_DIR"
        ;;

    LIST_DB )
        "$SCRIPTS_DIR/list_db.sh" "$DB_DIR"
        ;;

    CONNECT_DB )
        "$SCRIPTS_DIR/connect_db.sh" "$DB_DIR" "$SCRIPTS_DIR"
        ;;

    DROP_DB )
        "$SCRIPTS_DIR/drop_db.sh" "$DB_DIR"
        ;;

    EXIT )
        echo -e "\033[30mBye :)\033[0m"
        break
        ;;
    *)
        echo -e "\033[31mInvalid choice, try again\033[0m"
        ;;
    esac
done