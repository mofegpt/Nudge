package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	// "github.com/aws/aws-sdk-go-v2/credentials"
	// "github.com/aws/aws-sdk-go-v2/config"
	// "github.com/aws/aws-sdk-go-v2/service/s3"
	// "context"
	"github.com/joho/godotenv"

)

//GLOBAL VARIABLES
var mdb *MySQlDatabase

func main() {
	godotenv.Load()

	mdb = &MySQlDatabase{}
	mdb.init(os.Getenv("DBKEY"))

	// TODO: NOT SECURE!!
	fmt.Printf("\n\nThis is the key %s\n\n", os.Getenv("DBKEY"))

	//AWS Configuration and New Session Creation
	// awsAccessKey := os.Getenv("AWS_ACCESS_KEY")
	// awsSecretKey := os.Getenv("AWS_SECRET_KEY")
	// awsRegion := os.Getenv("AWS_BUCKET_REGION")
	// awsBucket := os.Getenv("AWS_BUCKET_NAME")

	// if awsAccessKey == "" || awsSecretKey == "" || awsRegion == "" || awsBucket == "" {
	// 	log.Fatal("AWS credentials or configuration missing")
	// }

	// Set up AWS S3 client
// 	cfg, err := config.LoadDefaultConfig(context.TODO(),
//     config.WithRegion(awsRegion), // Replace "us-west-2" with your AWS region
//     config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(awsAccessKey, awsSecretKey, "")),
// )	
// 	if err != nil {
// 		log.Fatal("Error loading AWS config:", err)
// 	}

	//s3Client := s3.NewFromConfig(cfg)

	http.HandleFunc("/test", handleTest)
	http.HandleFunc("/nearbyUsers", handleNearbyUsers)
	http.HandleFunc("/detailedNearbyUsers", handleDetailedNearbyUsers)
	// http.HandleFunc("/userInfo", handleCreateUser)
	http.HandleFunc("/userInfo", handleNudgerInfo)
	http.HandleFunc("/upload", playground)

	//http.HandleFunc("/upload", handleUploadToS3(s3Client, awsBucket))

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
		log.Printf("Default to port x%s ", port)
	}
	svrErr := http.ListenAndServe(": " + port, nil)
	if svrErr != nil {
		log.Fatal(svrErr)
	}
}
