// s3.go
package main

import (
	"bytes"
	"context"
	"fmt"
	"os"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

func uploadToS3(objectKey string, imageData []byte) (string, error) {
	awsAccessKey := os.Getenv("AWS_ACCESS_KEY")
	awsSecretKey := os.Getenv("AWS_SECRET_KEY")
	awsRegion := os.Getenv("AWS_BUCKET_REGION")
	awsBucket := os.Getenv("AWS_BUCKET_NAME")

	// Check for missing AWS credentials or configuration
	if awsAccessKey == "" || awsSecretKey == "" || awsRegion == "" || awsBucket == "" {
		fmt.Println("AWS credentials or configuration missing in upload")
	}

	// Set up AWS S3 client
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithRegion(awsRegion),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(awsAccessKey, awsSecretKey, "")),
	)
	if err != nil {
		fmt.Printf("Error loading AWS config: %v", err)
	}

	s3Client := s3.NewFromConfig(cfg)

	uploader := manager.NewUploader(s3Client)
	_, err = uploader.Upload(context.TODO(), &s3.PutObjectInput{
		Bucket: &awsBucket,
		Key:    &objectKey,
		Body:   bytes.NewBuffer(imageData),
	})
	if err != nil {
		fmt.Printf("Error loading AWS config: %v", err)
	}
	fmt.Printf("Successful Upload")
	// presignClient := s3.NewPresignClient(s3Client)
	// presignedUrl, err := presignClient.PresignGetObject(context.Background(),
	// 	&s3.GetObjectInput{
	// 		Bucket: aws.String(awsBucket),
	// 		Key:    aws.String(objectKey),
	// 	},
	// 	s3.WithPresignExpires(time.Minute*1))
	// if err != nil {
	// 	fmt.Printf("Error generating URL: %v", err)
	// }
	return "Successful Upload", nil
}

func downloadFromS3(objectKey string) (string, error){
	awsAccessKey := os.Getenv("AWS_ACCESS_KEY")
	awsSecretKey := os.Getenv("AWS_SECRET_KEY")
	awsRegion := os.Getenv("AWS_BUCKET_REGION")
	awsBucket := os.Getenv("AWS_BUCKET_NAME")

	// Check for missing AWS credentials or configuration
	if awsAccessKey == "" || awsSecretKey == "" || awsRegion == "" || awsBucket == "" {
		fmt.Println("AWS credentials or configuration missing in upload")
	}

	// Set up AWS S3 client
	cfg, err := config.LoadDefaultConfig(context.TODO(),
		config.WithRegion(awsRegion),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(awsAccessKey, awsSecretKey, "")),
	)
	if err != nil {
		fmt.Printf("Error loading AWS config: %v", err)
	}

	s3Client := s3.NewFromConfig(cfg)

	presignClient := s3.NewPresignClient(s3Client)
	presignedUrl, err := presignClient.PresignGetObject(context.Background(),
		&s3.GetObjectInput{
			Bucket: aws.String(awsBucket),
			Key:    aws.String(objectKey),
		},
		s3.WithPresignExpires(time.Minute*1))
	if err != nil {
		fmt.Printf("Error generating URL: %v", err)
	}
	return presignedUrl.URL, nil
}


