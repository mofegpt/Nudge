package main

import (
	"net/http"
)

func handleTest(w http.ResponseWriter, r *http.Request) {
	switch r.Method {
	case http.MethodGet:
		test := testJson{
			Message: "Hello Nudgers",
		}
		serveJSON(w, test, http.StatusOK)
	}

}

type testJson struct {
	Message string `json:"message"`
}
