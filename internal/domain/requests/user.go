package requests

import (
	"github.com/go-playground/validator/v10"
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	FullName    string `json:"fullname" validate:"required,min=3,max=100"`
	Email       string `json:"email" validate:"required"`
	PhoneNumber string `json:"phonenumber"`
	Birthday    string `json:"birthday"`
	Password    string `json:"password" validate:"required,min=8"`
	Address     string `json:"address"`
	Role        string `json:"role"`
	GoogleID    string `json:"google_id"`
}

type GoogleUser struct {
	ID            string `json:"id"`
	Email         string `json:"email"`
	VerifiedEmail bool   `json:"verified_email"`
	Name          string `json:"name"`
	GivenName     string `json:"given_name"`
	FamilyName    string `json:"family_name"`
	Picture       string `json:"picture"`
	Locale        string `json:"locale"`
}

func (u *User) Validate() error {
	validate := validator.New()
	return validate.Struct(u)
}
