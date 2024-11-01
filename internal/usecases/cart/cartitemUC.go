package cart

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/cart"
)

type CartItemUsecase interface {
	CreateCartItem(item *models.CartItem) error
	UpdateCartItem(item *models.CartItem) error
	DeleteCartItem(item *models.CartItem) error

	GetCartItemByID(id uint) (*models.CartItem, error)
}

type cartItemUsecase struct {
	cartItemRepo cart.CartItemRepository
}

func NewCartItemUsecase(cartItemRepo cart.CartItemRepository) CartItemUsecase {
	return &cartItemUsecase{cartItemRepo}
}

func (u *cartItemUsecase) CreateCartItem(item *models.CartItem) error {
	return u.cartItemRepo.CreateCartItem(item)
}

func (u *cartItemUsecase) UpdateCartItem(item *models.CartItem) error {
	return u.cartItemRepo.UpdateCartItem(item)
}

func (u *cartItemUsecase) DeleteCartItem(item *models.CartItem) error {
	return u.cartItemRepo.DeleteCartItem(item)
}

func (u *cartItemUsecase) GetCartItemByID(id uint) (*models.CartItem, error) {
	return u.cartItemRepo.GetCartItemByID(id)
}
