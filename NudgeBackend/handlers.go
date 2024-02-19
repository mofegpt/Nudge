package main

import (
	"fmt"
	"net/http"
	"strconv"

	"encoding/base64"
//	"github.com/google/uuid"
)

type Parameters struct {
	ID        string `json:"nudger_id"`
	FirstName   string `json:"first_name"`
	LastName    string `json:"last_name"`
	Bio         string `json:"bio"`
	PicturePath string
	Age         string `json:"age"`
	Email       string `json:"email"`
	// ImageBase64 []byte `json:"image_base64"`

	ImageBase64 string `json:"image_base64"`
}

func handleNearbyUsers(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		lon, _ := strconv.ParseFloat(r.FormValue("longitude"), 64)
		lat, _ := strconv.ParseFloat(r.FormValue("latitude"), 64)

		result := getNearbyUsers(lon, lat)
		m := make(map[string][]UserLocation)
		m["nearby_users"] = result
		serveJSON(w, m, http.StatusOK)
	}
}

func handleDetailedNearbyUsers(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		lon, _ := strconv.ParseFloat(r.FormValue("longitude"), 64)
		lat, _ := strconv.ParseFloat(r.FormValue("latitude"), 64)
		result := getDetailedNearbyUsers(lon, lat)
		m := make(map[string][]DetailedUser)
		m["nearby_detailed_list"] = result
		serveJSON(w, m, http.StatusOK)
	}

}

func handleNudgerInfo(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		id := r.FormValue("id")
		result := getNudgerInfo(id)
		serveJSON(w, result, http.StatusOK)

	case http.MethodPost:
		var params *Parameters
		err := decodeJSON(r, &params)

		if err != nil {
			//	respondWithError(w, 400, fmt.Sprintf("Error parsing JSON: %s", err))
			serveJSONError(w, "Error parsing JSON: ", err, "JSON", http.StatusBadRequest, http.StatusBadRequest)
		}
		imageBytes, err := base64.StdEncoding.DecodeString(params.ImageBase64)
		if err != nil {
			http.Error(w, "Error decoding base64 image data", http.StatusBadRequest)
			return
		}

		url, err := uploadToS3("SWIFT", imageBytes)
		if err != nil {
			http.Error(w, "Error getting url", http.StatusBadRequest)
		}

		params.PicturePath = url
		fmt.Println("url:", url)
		user, err := CreateUser(r.Context(), NudgerInfo{
			// NudgerID:    uuid.New(),
			NudgerID:    params.ID,
			FirstName:   params.FirstName,
			LastName:    params.LastName,
			Age:         params.Age,
			PicturePath: params.PicturePath,
			Email:       params.Email,
			Bio:         params.Bio,
		})
		if err != nil {
			serveJSONError(w, "Error parsing creating user: ", err, "JSON", http.StatusBadRequest, http.StatusBadRequest)
			_ = fmt.Errorf("Error creating user: %v", err)
			return
		}
		//respondWithJSON(w, 200, user)
		serveJSON(w, user, http.StatusAccepted)

	case http.MethodPut:
		var user *NudgerInfo
		err := decodeJSON(r, &user)

		if err != nil {
			fmt.Printf("could not decode user info json: %s\n", err)
			serveJSONError(w, "could not decode user info", err, "JSON",
				http.StatusBadRequest, http.StatusBadRequest)
		} else {
			err := updateNudger(*user)

			if err != nil {
				fmt.Printf("Error in updating user: %s\n", err)
				serveJSONError(w, "Error in updating user", err, "JSON",
					http.StatusBadRequest, http.StatusBadRequest)
			} else {
				success := testJson{
					Message: "Successfull",
				}
				serveJSON(w, success, http.StatusOK)
			}

		}

	}
}

// func handleNudgerInfo(w http.ResponseWriter, r *http.Request) {
// 	switch r.Method {
// 	case http.MethodGet:
// 		id := r.FormValue("id")
// 		result := getNudgerInfo(id)
// 		serveJSON(w, result, http.StatusOK)

// 	case http.MethodPost:
// 		var user *NudgerInfo
// 		err := decodeJSON(r, &user)

// 		if err != nil {
// 			fmt.Printf("could not decode user info json: %s\n", err)
// 			serveJSONError(w, "could not decode user info", err, "JSON",
// 				http.StatusBadRequest, http.StatusBadRequest)
// 		} else {
// 			err := createNudger(*user)

// 			if err != nil {
// 				fmt.Printf("Error in creating user: %s\n", err)
// 				serveJSONError(w, "Error in creating user", err, "JSON",
// 					http.StatusBadRequest, http.StatusBadRequest)
// 			} else {
// 				success := testJson{
// 					Message: "Successful",
// 				}
// 				serveJSON(w, success, http.StatusOK)
// 			}

// 		}

// 	case http.MethodPut:
// 		var user *NudgerInfo
// 		err := decodeJSON(r, &user)

// 		if err != nil {
// 			fmt.Printf("could not decode user info json: %s\n", err)
// 			serveJSONError(w, "could not decode user info", err, "JSON",
// 				http.StatusBadRequest, http.StatusBadRequest)
// 		} else {
// 			err := updateNudger(*user)

// 			if err != nil {
// 				fmt.Printf("Error in updating user: %s\n", err)
// 				serveJSONError(w, "Error in updating user", err, "JSON",
// 					http.StatusBadRequest, http.StatusBadRequest)
// 			} else {
// 				success := testJson{
// 					Message: "Successfull",
// 				}
// 				serveJSON(w, success, http.StatusOK)
// 			}

// 		}

// 	}
// }

// func handleCreateUser(w http.ResponseWriter, r *http.Request) {
// 	switch r.Method {
// 	case http.MethodPost:
// 		var user *NudgerInfo
// 		err := decodeJSON(r, &user)

// 		if err != nil {
// 			log.Fatal("could not decode user info json", err)
// 			serveJSONError(w, "could not decode user info", err, "JSON",
// 				http.StatusBadRequest, http.StatusBadRequest)
// 		}

// 		serveJSON(w, createNudger(*user), http.StatusOK)
// 	}
// }
