package user

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type UserRepository interface {
	CreateUser(users *models.User) error
	DeleteUser(users *models.User) error
	UpdateUser(users *models.User) error

	GetUserByID(id uint) (*models.User, error)
	GetUserByGoogleID(googleID string) (*models.User, error)
	GetUserByPhoneNumber(phonenumber string) (*models.User, error)
	GetUserByEmail(email string) (*models.User, error)
}

type userRepository struct {
	db *gorm.DB
}

func NewUserRepository(db *gorm.DB) UserRepository {
	return &userRepository{db}
}

func (r *userRepository) CreateUser(users *models.User) error {
	return r.db.Create(users).Error
}

func (r *userRepository) DeleteUser(users *models.User) error {
	return r.db.Model(&models.User{}).Where("id = ?", users.ID).Delete(users).Error
}

func (r *userRepository) UpdateUser(users *models.User) error {
	return r.db.Save(users).Error
}

func (r *userRepository) GetUserByID(id uint) (*models.User, error) {
	var user models.User
	err := r.db.First(&user, id).Error
	return &user, err
}

func (r *userRepository) GetUserByGoogleID(googleID string) (*models.User, error) {
	var user models.User
	if err := r.db.Where("google_id = ?", googleID).First(&user).Error; err != nil {
		return nil, err
	}

	return &user, nil
}

func (r *userRepository) GetUserByPhoneNumber(phonenumber string) (*models.User, error) {
	var user models.User
	if err := r.db.Where("phone_number = ?", phonenumber).First(&user).Error; err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *userRepository) GetUserByEmail(email string) (*models.User, error) {
	var user models.User
	if err := r.db.Where("email = ?", email).First(&user).Error; err != nil {
		return nil, err
	}
	return &user, nil
}