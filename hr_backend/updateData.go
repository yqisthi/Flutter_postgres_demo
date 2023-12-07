package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func updateDataHandler(w http.ResponseWriter, r *http.Request) {
	db, err := getDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Decode the JSON request body into an Item struct
	var updatedItem Item
	err = json.NewDecoder(r.Body).Decode(&updatedItem)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	// Get the email parameter from the query string
	emailParam := r.URL.Query().Get("email")

	// Check if the email parameter is provided
	if emailParam == "" {
		http.Error(w, "Missing 'email' parameter", http.StatusBadRequest)
		return
	}

	// Use a prepared statement to prevent SQL injection
	_, err = db.Exec("UPDATE \"user\" SET email = $1, name = $2,  password = $3, role = $4 WHERE email = $5",updatedItem.Email, updatedItem.Name, updatedItem.Password, updatedItem.Role, emailParam)
	if err != nil {
		log.Fatal(err)
		http.Error(w, "Error updating data in the database", http.StatusInternalServerError)
		return
	}

	// Respond with a success message
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"message": "Data updated successfully"})
}
