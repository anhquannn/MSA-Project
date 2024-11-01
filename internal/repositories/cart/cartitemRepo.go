package cart

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type CartItemRepository interface {
	CreateCartItem(cartitem *models.CartItem) error
	DeleteCartItem(cartitem *models.CartItem) error
	UpdateCartItem(cartitem *models.CartItem) error

	GetCartItemByID(id uint) (*models.CartItem, error)
}

type cartItemRepository struct {
	db *gorm.DB
}

func NewCartItemRepository(db *gorm.DB) CartItemRepository {
	return &cartItemRepository{db}
}

func (r *cartItemRepository) CreateCartItem(cartitem *models.CartItem) error {
	return r.db.Create(cartitem).Error
}

func (r *cartItemRepository) DeleteCartItem(cartitem *models.CartItem) error {
	return r.db.Model(&models.Cart{}).Where("id = ?", cartitem.ID).Delete(cartitem).Error
}

func (r *cartItemRepository) UpdateCartItem(cartitem *models.CartItem) error {
	return r.db.Save(cartitem).Error
}

func (r *cartItemRepository) GetCartItemByID(id uint) (*models.CartItem, error) {
	var cartitem models.CartItem
	err := r.db.First(&cartitem, id).Error
	return &cartitem, err
}
