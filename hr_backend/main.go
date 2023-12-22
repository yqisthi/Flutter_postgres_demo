package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

type Item struct {
	Email string `json:"email"`
	Name  string `json:"name"`
	Password string `json:"password"`
	Role string `json:"role"`
	Otp string `json:"otp"`
}

const (
	host     = "localhost"
	port     = 5433
	user     = "postgres"
	password = "12345678"
	dbname   = "haus_flutter"
)

func getDB() (*sql.DB, error) {
	connStr := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return nil, err
	}
	return db, nil
}


func main() {
	http.HandleFunc("/getdata", getDataHandler)
	http.HandleFunc("/getalldata", getAllDataHandler)
	http.HandleFunc("/createdata", createDataHandler)
	http.HandleFunc("/deletedata", deleteDataHandler)
	http.HandleFunc("/updatedata", updateDataHandler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
