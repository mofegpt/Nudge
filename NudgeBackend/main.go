package main

import (
	"log"
	"net/http"
	"os"
)

//GLOBAL VARIABLES
var mdb *MySQlDatabase

func main() {

	mdb = &MySQlDatabase{}

	// TODO: NOT SECURE!!
	mdb.init("root:manifest+123@tcp(localhost:3306)/NudgeDB")
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Default to port %s ", port)
		http.HandleFunc("/test", handleTest)
		http.HandleFunc("/nearbyUsers", handleNearbyUsers)
	}

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}
