package main

import (
	"encoding/json"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

func createDataHandler(w http.ResponseWriter, r *http.Request) {
	db, err := getDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Decode the JSON request body into an Item struct
	var newItem Item
	err = json.NewDecoder(r.Body).Decode(&newItem)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	// Use a prepared statement to prevent SQL injection
	_, err = db.Exec("INSERT INTO \"user\" (email, name, password, role) VALUES ($1, $2, $3, $4)", newItem.Email, newItem.Name, newItem.Password, newItem.Role)
	if err != nil {
		log.Fatal(err)
		http.Error(w, "Error inserting data into the database", http.StatusInternalServerError)
		return
	}

	// Respond with a success message
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(map[string]string{"message": "Data created successfully"})
}
