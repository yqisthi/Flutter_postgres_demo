package main

import (
	"encoding/json"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)
func deleteDataHandler(w http.ResponseWriter, r *http.Request) {
	db, err := getDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Get the email parameter from the query string
	emailParam := r.URL.Query().Get("email")

	// Check if the email parameter is provided
	if emailParam == "" {
		http.Error(w, "Missing 'email' parameter", http.StatusBadRequest)
		return
	}

	// Use a prepared statement to prevent SQL injection
	_, err = db.Exec("DELETE FROM \"user\" WHERE email = $1", emailParam)
	if err != nil {
		log.Fatal(err)
		http.Error(w, "Error deleting data from the database", http.StatusInternalServerError)
		return
	}

	// Respond with a success message
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Data deleted successfully"})
}
