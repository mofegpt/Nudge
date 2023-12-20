package main

import (
	"log"
	"net/http"
	"os"
)

func main() {

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Default to port %s ", port)
		http.HandleFunc("/test", handleTest)
	}

	err := http.ListenAndServe(":"+port, nil)
	if err != nil {
		log.Fatal(err)
	}
}
