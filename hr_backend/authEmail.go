package main

import (
	"log"
	"math/rand"
	"net/smtp"
	"strconv"
	"time"
)

// Email configuration
const (
	smtpServer   = "smtp.gmail.com"
	smtpPort     = 587
	smtpUsername = "hrdummyhaus1@gmail.com"
	smtpPassword = "brol ppka nkja xsfq"
)



// Function to send an email
// Function to send an email with OTP
func sendOTPEmail(to, otpCode string) error {
	auth := smtp.PlainAuth("", smtpUsername, smtpPassword, smtpServer)

	// Compose the HTML email
	subject := "Haus HR App OTP Verification"
	body := "<p>Dear User,</p>" +
		"<p>Your OTP code for Haus HR APP verification is: <strong>" + otpCode + "</strong></p>" +
		"<p>Enter this code in your application to complete the verification process.</p>"

	msg := "MIME-version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";\nSubject: " + subject + "\n\n" + body

	// Send the email
	err := smtp.SendMail(smtpServer+":"+strconv.Itoa(smtpPort), auth, smtpUsername, []string{to}, []byte(msg))
	if err != nil {
		return err
	}
	return nil
}

func randomOTP() string {
	// Seed the random number generator with the current time
	rand.Seed(time.Now().UnixNano())

	// Generate a random integer in the range [100000, 999999]
	randomNumber := rand.Intn(900000) + 100000

	// Convert the random number to a string
	randomString := strconv.Itoa(randomNumber)
	return randomString
}

func Auth(to string, otpCode string) {
	err := sendOTPEmail(to, otpCode)
	if err != nil {
		log.Fatal("Error sending OTP email: ", err)
	} else {
		log.Println("OTP email sent successfully!")
	}
}
