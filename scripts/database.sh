#!/bin/bash

SCRIPTS_DIR="."
DB_DIR="../db"

PS3="Choose an option: "

select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB EXIT
do
    case $choice in

    CREATE_DB )
        "$SCRIPTS_DIR/create_db.sh" "$DB_DIR"
        ;;

    LIST_DB )
         "$SCRIPTS_DIR/list_db.sh" "$DB_DIR"
        ;;

    CONNECT_DB )
         "$SCRIPTS_DIR/connect_db.sh" "$DB_DIR"
        ;;

    DROP_DB )
         "$SCRIPTS_DIR/drop_db.sh" "$DB_DIR"
        ;;

    EXIT )
        echo "Exit"
        break
        ;;
    *)
        echo "Invalid choice, try again"
        ;;
    esac
done
