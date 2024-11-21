package cart

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type CartItemRepository interface {
	CreateCartItem(artitem *models.CartItem) error
	DeleteCartItem(cartitem *models.CartItem) error
	ClearCart(cartID uint) error
	UpdateCartItem(cartitem *models.CartItem) error
	GetCartItem(cartID, productID uint) (*models.CartItem, error)
	GetCartItemsByCartID(cartID uint, cartItems *[]models.CartItem) error

	GetCartItemByID(id uint) (*models.CartItem, error)

	CalculateCartTotal(cartID uint) (float64, error)
}

type cartItemRepository struct {
	db *gorm.DB
}

func NewCartItemRepository(db *gorm.DB) CartItemRepository {
	return &cartItemRepository{db}
}

func (r *cartItemRepository) CreateCartItem(cartitem *models.CartItem) error {
	return r.db.Create(cartitem).Preload("Cart").Preload("Product").First(cartitem, cartitem.ID).Error
}

func (r *cartItemRepository) GetCartItem(cartID, productID uint) (*models.CartItem, error) {
	var cartItem models.CartItem
	err := r.db.Preload("Cart").Preload("Product").Where("cart_id = ? AND product_id = ?", cartID, productID).First(&cartItem).Error
	if err == gorm.ErrRecordNotFound {
		return nil, nil
	} else if err != nil {
		return nil, err
	}
	return &cartItem, nil
}

func (r *cartItemRepository) DeleteCartItem(cartitem *models.CartItem) error {
	return r.db.Model(&models.Cart{}).Where("id = ?", cartitem.ID).Delete(cartitem).Error
}

func (r *cartItemRepository) ClearCart(cartID uint) error {
	return r.db.Where("cart_id = ?", cartID).Delete(&models.CartItem{}).Error
}

func (r *cartItemRepository) UpdateCartItem(cartitem *models.CartItem) error {
	return r.db.Save(cartitem).Preload("Cart").Preload("Product").First(cartitem, cartitem.ID).Error
}

func (r *cartItemRepository) GetCartItemByID(id uint) (*models.CartItem, error) {
	var cartitem models.CartItem
	err := r.db.Preload("Cart").Preload("Product").First(&cartitem, id).Error
	return &cartitem, err
}

func (r *cartItemRepository) GetCartItemsByCartID(cartID uint, cartItems *[]models.CartItem) error {
	return r.db.Preload("Cart").Preload("Product").Where("cart_id = ?", cartID).Find(cartItems).Error
}

func (r *cartItemRepository) CalculateCartTotal(cartID uint) (float64, error) {
	var cartItems []models.CartItem
	var total float64

	err := r.db.Where("cart_id = ?", cartID).Find(&cartItems).Error
	if err != nil {
		return 0, err
	}

	for _, item := range cartItems {
		total += item.Price * float64(item.Quantity)
	}

	return total, nil
}
