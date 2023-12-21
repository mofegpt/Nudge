package main

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

//Created just so the sql database opens once and also
//inserts myTime and location into the database once

type MySQlDatabase struct {
	db               *sql.DB
	stmtInsertTrip   *sql.Stmt
	stmtUpdateConfig *sql.Stmt
}

// filepathname: username:password@protocol(address)/dbname?param=value
//root:manifest+123@tcp(localhost:3306)/NudgeDB
func (me *MySQlDatabase) init(filepath string) {
	db, err := sql.Open("mysql", filepath)
	if err != nil {
		panic(err)
	}
	if db == nil {
		panic("db nil")
	}
	me.db = db

	err = db.Ping()
	if err != nil {
		fmt.Println("error verifying the connection with ping")
		panic(err)
	}

	fmt.Println("successfully connected :')")
}
