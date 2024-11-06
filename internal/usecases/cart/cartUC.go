package cart

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/cart"
)

type CartUsecase interface {
	CreateCart(cart *models.Cart) error
	UpdateCart(cart *models.Cart) error
	DeleteCart(cart *models.Cart) error

	GetCartByID(id uint) (*models.Cart, error)
	GetOrCreateCartForUser(userID uint) (*models.Cart, error)
}

type cartUsecase struct {
	cartRepo cart.CartRepository
}

func NewCartUsecase(cartRepo cart.CartRepository) CartUsecase {
	return &cartUsecase{cartRepo}
}

func (u *cartUsecase) CreateCart(cart *models.Cart) error {
	return u.cartRepo.CreateCart(cart)
}

func (u *cartUsecase) UpdateCart(cart *models.Cart) error {
	return u.cartRepo.UpdateCart(cart)
}

func (u *cartUsecase) DeleteCart(cart *models.Cart) error {
	return u.cartRepo.DeleteCart(cart)
}

func (u *cartUsecase) GetCartByID(id uint) (*models.Cart, error) {
	return u.cartRepo.GetCartByID(id)
}

func (u *cartUsecase) GetOrCreateCartForUser(userID uint) (*models.Cart, error) {
	cart, err := u.cartRepo.GetCartByUserID(userID)
	if err != nil {
		return nil, err
	}

	if cart == nil {
		newCart := &models.Cart{UserID: userID, Status: "active"}
		if err := u.cartRepo.CreateCart(newCart); err != nil {
			return nil, err
		}
		return newCart, nil
	}

	return cart, nil
}
