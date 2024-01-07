package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

//GLOBAL VARIABLES
var mdb *MySQlDatabase

func main() {

	mdb = &MySQlDatabase{}

	// TODO: NOT SECURE!!
	fmt.Printf("\n\nThis is the key %s\n\n", os.Getenv("DBKEY"))

	mdb.init(os.Getenv("DBKEY"))
	http.HandleFunc("/test", handleTest)
	http.HandleFunc("/nearbyUsers", handleNearbyUsers)
	http.HandleFunc("/detailedNearbyUsers", handleDetailedNearbyUsers)
	http.HandleFunc("/userInfo", handleNudgerInfo)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Default to port x%s ", port)
	}
	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}
