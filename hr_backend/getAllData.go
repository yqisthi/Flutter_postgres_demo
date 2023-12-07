package main

import (
	"encoding/json"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

func getAllDataHandler(w http.ResponseWriter, r *http.Request) {
	db, err := getDB()
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	
	rows, err := db.Query("SELECT email, name, password, role FROM \"user\"")
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
