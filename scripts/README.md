# Bash DBMS Project

A simple Database Management System (DBMS) implemented using **Bash scripting**.
This project simulates basic database operations using directories and files,
without using any external database engine.

The main purpose of this project is to practice:

- Bash scripting
- File handling
- Text processing using `awk`
- Building menu-driven CLI applications

---

## 📁 Project Structure

````project

db_engine/
│── scripts/
├──── database.sh
├──── create_db.sh
├──── list_db.sh
├──── connect_db.sh
├──── drop_db.sh
│
├──── create_table.sh
├──── list_table.sh
├──── drop_table.sh
├──── insert_row.sh
├──── show_data.sh
├──── delete_row.sh
├──── update_cell.sh
│
└── db/


```Database Design

- Each database is represented as a directory.
- Each table is represented as a file inside the database directory.
- The first line of each table file is always the header.

````

Header format:

- columnName:columnType:columnName:columnType

````
Example Table:
    id:integer:name:string
    1:Ali
    2:Ahmed

```How to run

=> git clone https://github.com/mahmoudrabbas/db_engine.git
=> mkdir db
=> chmod +x *.sh
=> ./database.sh

````

## 🎯 Project Goal

- This project was created as a learning exercise to understand:
- Basic database concepts
- File-based data storage
- How Bash scripting can be used to build real CLI tools

```
Author
@mahmoudrabbas
@abdalrahmanalirajab
```
