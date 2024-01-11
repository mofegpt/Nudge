package main

import (
	"fmt"
	"net/http"
	"strconv"
)

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
		var user *NudgerInfo
		err := decodeJSON(r, &user)

		if err != nil {
			fmt.Printf("could not decode user info json: %s\n", err)
			serveJSONError(w, "could not decode user info", err, "JSON",
				http.StatusBadRequest, http.StatusBadRequest)
		} else {
			err := createNudger(*user)

			if err != nil {
				fmt.Printf("Error in creating user: %s\n", err)
				serveJSONError(w, "Error in creating user", err, "JSON",
					http.StatusBadRequest, http.StatusBadRequest)
			} else {
				success := testJson{
					Message: "Successful",
				}
				serveJSON(w, success, http.StatusOK)
			}

		}

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
