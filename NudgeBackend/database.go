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
	stmtInsertUser   *sql.Stmt
	stmtUpdateUser   *sql.Stmt
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

	me.stmtInsertUser, err = db.Prepare(`
	INSERT INTO user_profile (nudger_id, first_name, last_name, born, bio, image, email)
	VALUES (?, ?, ?, ?, ?, ?, ?);
	`)

	if err != nil {
		panic(err)
	}

	me.stmtUpdateUser, err = db.Prepare(`
	UPDATE user_profile
	SET first_name = ?, last_name = ?, born = ?, bio = ?, image = ?, email = ?
	WHERE (nudger_id = ?);
	`)

	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		fmt.Println("error verifying the connection with ping")
		panic(err)
	}

	fmt.Println("Successfully connected to the Database!")
}
