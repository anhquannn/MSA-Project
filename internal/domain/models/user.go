package models

import (
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	FullName    string `json:"fullname"`
	Email       string `json:"email"`
	PhoneNumber string `json:"phonenumber"`
	Birthday    string `json:"birthday"`
	Password    string `json:"password"`
	Address     string `json:"address"`
	Role        string `json:"role"`
	GoogleID    string `json:"google_id"`
}
