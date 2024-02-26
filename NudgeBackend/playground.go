package main

import(
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"time"
	"os"
	"context"
	"net/http"
	"fmt"
)
// type Parameters struct {
// 	//	NudgerID    uuid.UUID `json:"nudger_id"`
// 	FirstName   string `json:"first_name"`
// 	LastName    string `json:"last_name"`
// 	Bio         string `json:"bio"`
// 	PicturePath string
// 	Age         string `json:"age"`
// 	Email       string `json:"email"`
// 	ImageBase64 string `json:"image_base64"`
// }

func playground(w http.ResponseWriter, r *http.Request){
		switch r.Method {
		case http.MethodPost:
			_,img, err := r.FormFile("image")
			if err != nil{
				serveJSONError(w, "Error in reading form", err, "JSON",http.StatusBadRequest, http.StatusBadRequest)
			}
	f, err := img.Open()
	if err != nil {
		serveJSONError(w, "Error opening image file", err, "JSON",http.StatusBadRequest, http.StatusBadRequest)
	}
	
	
	
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
	result,err := uploader.Upload(context.TODO(), &s3.PutObjectInput{
		Bucket: &awsBucket,
		Key:    aws.String(img.Filename),
		Body:   f,
	})
			
			serveJSON(w, result.Location, http.StatusOK)
	
			presignClient := s3.NewPresignClient(s3Client)
		presignedUrl, err := presignClient.PresignGetObject(context.Background(),
			&s3.GetObjectInput{
				Bucket: aws.String(awsBucket),
				Key:    aws.String(img.Filename),
			},
			s3.WithPresignExpires(time.Minute*1))
		if err != nil {
			fmt.Printf("Error generating URL: %v", err)
		}
		fmt.Printf("URL: %v", presignedUrl)
		}
	}	

// func handleCreateUser(w http.ResponseWriter, r *http.Request) {
// 	// type parameters struct {
// 	// 	//	NudgerID    uuid.UUID `json:"nudger_id"`
// 	// 	FirstName   string `json:"first_name"`
// 	// 	LastName    string `json:"last_name"`
// 	// 	Bio         string `json:"bio"`
// 	// 	PicturePath string
// 	// 	Age         string `json:"age"`
// 	// 	Email       string `json:"email"`
// 	// 	ImageBase64 string `json:"image_base64"`
// 	// }

// 	params := Parameters{}
// 	err := json.NewDecoder(r.Body).Decode(&params)
// 	if err != nil {
// 		//	respondWithError(w, 400, fmt.Sprintf("Error parsing JSON: %s", err))
// 		serveJSONError(w, "Error parsing JSON: ", err, "JSON", http.StatusBadRequest, http.StatusBadRequest)
// 	}
// 	imageBytes, err := base64.StdEncoding.DecodeString(params.ImageBase64)
// 	if err != nil {
// 		http.Error(w, "Error decoding base64 image data", http.StatusBadRequest)
// 		return
// 	}

// 	url, err := uploadToS3("filename", imageBytes)
// 	if err != nil {
// 		http.Error(w, "Error getting url", http.StatusBadRequest)
// 	}

// 	params.PicturePath = url
// 	fmt.Println("url:", url)

// 	// respondWithJSON(w, 200, struct{}{})

// 	user, err := CreateUser(r.Context(), CreateUserParams{
// 		ID:          uuid.New(),
// 		FirstName:   params.FirstName,
// 		LastName:    params.LastName,
// 		Age:         params.Age,
// 		PicturePath: params.PicturePath,
// 		Email:       params.Email,
// 		Bio:         params.Bio,
// 	})
// 	if err != nil {
// 		serveJSONError(w, "Error parsing creating user: ", err, "JSON", http.StatusBadRequest, http.StatusBadRequest)
// 		fmt.Errorf("Error creating user: ", err)
// 	}
// 	//respondWithJSON(w, 200, user)
// 	serveJSON(w, user, http.StatusAccepted)
// }

// import (
// 	"bytes"
// 	"context"
// 	"fmt"
// 	"net/http"
// 	"os"
// 	"github.com/aws/aws-sdk-go-v2/aws"
// 	"github.com/aws/aws-sdk-go-v2/service/s3"
// )

// func handleUploadToS3(s3Client *s3.Client, bucket string) http.HandlerFunc {
// 	return func(w http.ResponseWriter, r *http.Request) {
// 		// Path to the image file on your local machine
// 		imageFilePath := "path/to/your/image.jpg"

// 		// Read the image file
// 		imageData, err := os.ReadFile(imageFilePath)
// 		if err != nil {
// 			http.Error(w, fmt.Sprintf("Error reading image file: %v", err), http.StatusInternalServerError)
// 			return
// 		}

// 		// Extract the file name from the image file path
// 		fileName := "image.jpg" // Adjust this to use the actual file name if needed

// 		// Upload the file to AWS S3
// 		_, err = s3Client.PutObject(context.TODO(), &s3.PutObjectInput{
// 			Bucket: aws.String(bucket),
// 			Key:    aws.String(fileName),
// 			Body:   bytes.NewReader(imageData),
// 		})
// 		if err != nil {
// 			http.Error(w, fmt.Sprintf("Error uploading file to S3: %v", err), http.StatusInternalServerError)
// 			return
// 		}

// 		w.Write([]byte("File uploaded successfully"))
// 	}
// }
