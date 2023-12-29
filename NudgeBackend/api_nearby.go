package main

import (
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
		id, _ := strconv.Atoi(r.FormValue("id"))
		result := getNudgerInfo(id)
		serveJSON(w, result, http.StatusOK)
	}
}
