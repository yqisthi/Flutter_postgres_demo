package main

import (
	"encoding/json"
	"net/http"
)

// getDataHandler handles HTTP requests to fetch user data
func getDataHandler(w http.ResponseWriter, r *http.Request) {
	// Open a database connection
	db, err := getDB()
	if err != nil {
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer db.Close()

	// Get the email and password parameters from the query string
	emailParam := r.URL.Query().Get("email")
	passParam := r.URL.Query().Get("password")

	// Check if both email and password parameters are provided
	if emailParam == "" || passParam == "" {
		http.Error(w, "Missing 'email' or 'password' parameter", http.StatusBadRequest)
		return
	}

	// Use a prepared statement to prevent SQL injection
	rows, err := db.Query("SELECT email, name, password, role FROM \"user\" WHERE email = $1 AND password = $2", emailParam, passParam)
	if err != nil {
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var items []Item
	for rows.Next() {
		var user Item
		err := rows.Scan(&user.Email, &user.Name, &user.Password, &user.Role)
		if err != nil {
			http.Error(w, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		// Generate and set the OTP for the user
		otp := randomOTP()
		user.Otp = otp
		Auth(user.Email, user.Otp)

		// Append the user to the items slice
		items = append(items, user)
	}

	// Convert the items to JSON
	jsonData, err := json.Marshal(items)
	if err != nil {
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	// Set the Content-Type header to application/json
	w.Header().Set("Content-Type", "application/json")

	// Write the JSON data to the response writer
	w.Write(jsonData)
}
