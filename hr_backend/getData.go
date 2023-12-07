package main

import (
	"encoding/json"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

func getDataHandler(w http.ResponseWriter, r *http.Request) {
	db, err := getDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Get the email and name parameters from the query string
	emailParam := r.URL.Query().Get("email")
	passParam := r.URL.Query().Get("password")

	// Check if both email and name parameters are provided
	if emailParam == "" || passParam == "" {
		http.Error(w, "Missing 'email' or 'password' parameter", http.StatusBadRequest)
		return
	}

	// Use a prepared statement to prevent SQL injection
	
	rows, err := db.Query("SELECT email, name, password, role FROM \"user\" WHERE email = $1 AND password = $2", emailParam, passParam)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	var items []Item
	for rows.Next() {
		var item Item
		err := rows.Scan(&item.Email, &item.Name, &item.Password, &item.Role)
		if err != nil {
			log.Fatal(err)
		}
		items = append(items, item)
	}

	// Convert the items to JSON
	jsonData, err := json.Marshal(items)
	if err != nil {
		log.Fatal(err)
	}

	// Set the Content-Type header to application/json
	w.Header().Set("Content-Type", "application/json")

	// Write the JSON data to the response writer
	w.Write(jsonData)
}
