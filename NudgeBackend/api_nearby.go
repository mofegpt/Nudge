package main

import "net/http"

func handleNearbyUsers(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		result := getNearbyUsers()
		m := make(map[string][]UserLocation)
		m["nearby_users"] = result
		serveJSON(w, m, http.StatusOK)
	}
}
