#!/bin/bash

select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB
do
case $choice in 
CREATE_DB )
    echo "creating db"
    ./create_db.sh
    ;;
LIST_DB )
    echo "listing db"
    ./list_db.sh
    ;;
CONNECT_DB )
    echo "connecting db"
    ./connect_db.sh
    ;;
DROP_DB )
    echo "dropping db"
    ./drop_db.sh
    ;;
* )
    echo "invalid choice"
esac
done