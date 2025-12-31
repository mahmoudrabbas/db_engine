#!/bin/bash

SCRIPTS_DIR="."
DB_DIR="./db"

PS3="Choose an option: "

select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB EXIT
do
    case $choice in

    CREATE_DB)
        echo "Creating database..."
        "$SCRIPTS_DIR/create_db.sh" "$DB_DIR"
        ;;

    LIST_DB)
        echo "Listing databases..."
         "$SCRIPTS_DIR/list_db.sh" "$DB_DIR"
        ;;

    CONNECT_DB)
        echo "Connecting to database..."
         "$SCRIPTS_DIR/connect_db.sh" "$DB_DIR"
        ;;

    DROP_DB)
        echo "Dropping database..."
         "$SCRIPTS_DIR/drop_db.sh" "$DB_DIR"
        ;;

    EXIT)
        echo "Exit"
        break
        ;;
    *)
        echo "Invalid choice, try again"
        ;;
    esac
done
