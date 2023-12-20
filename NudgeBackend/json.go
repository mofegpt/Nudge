package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func serveJSON(w http.ResponseWriter, body interface{}, httpstatus int) {
	data, _ := json.Marshal(body)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(httpstatus)
	w.Write(data)
}

func decodeJSON(r *http.Request, dst interface{}) error {

	defer r.Body.Close()

	if r.Body == nil {
		return fmt.Errorf("missing JSON body")
	}

	err := json.NewDecoder(r.Body).Decode(dst)
	if err != nil {
		return fmt.Errorf("cant decode JSON %s", err)
	}

	return nil
}

// send a json error message
//
// w - output
// msg - user readable message
// err - error object
// errType - application error type
// intcode - internal error code
// httpCode - http status code
func serveJSONError(w http.ResponseWriter, msg string, err error, errType string, intcode int,
	httpCode int) {
	serveJSON(w, &jsonError{
		Message: msg,
		Detail:  err.Error(),
		Type:    errType,
		Code:    intcode,
	}, httpCode)
}

type jsonError struct {
	Message string `json:"message"` // user message
	Detail  string `json:"detail"`
	Type    string `json:"type"`
	Code    int    `json:"code"`
}
