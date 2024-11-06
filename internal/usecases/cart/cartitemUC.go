package cart

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/cart"
)

type CartItemUsecase interface {
	CreateCartItem(item *models.CartItem) error
	GetCartItem(cartID, productID uint) (*models.CartItem, error)
	UpdateCartItem(item *models.CartItem) error
	DeleteCartItem(item *models.CartItem) error
	ClearCart(cartID uint) error

	GetCartItemByID(id uint) (*models.CartItem, error)
	GetCartItemsByCartID(cartID uint) ([]models.CartItem, error)
	AddProductToCart(cartID, productID uint, quantity int) error
	CalculateCartTotal(cartID uint) (float64, error)
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

func (u *cartItemUsecase) GetCartItem(cartID, productID uint) (*models.CartItem, error) {
	return u.cartItemRepo.GetCartItem(cartID, productID)
}

func (u *cartItemUsecase) UpdateCartItem(item *models.CartItem) error {
	return u.cartItemRepo.UpdateCartItem(item)
}

func (u *cartItemUsecase) DeleteCartItem(item *models.CartItem) error {
	return u.cartItemRepo.DeleteCartItem(item)
}

func (u *cartItemUsecase) ClearCart(cartID uint) error {
	return u.cartItemRepo.ClearCart(cartID)
}

func (u *cartItemUsecase) GetCartItemByID(id uint) (*models.CartItem, error) {
	return u.cartItemRepo.GetCartItemByID(id)
}

func (u *cartItemUsecase) GetCartItemsByCartID(cartID uint) ([]models.CartItem, error) {
	var cartItems []models.CartItem
	err := u.cartItemRepo.GetCartItemsByCartID(cartID, &cartItems)
	if err != nil {
		return nil, err
	}
	return cartItems, nil
}

func (u *cartItemUsecase) AddProductToCart(cartID, productID uint, quantity int) error {
	cartItem, err := u.cartItemRepo.GetCartItem(cartID, productID)
	if err != nil {
		return err
	}

	if cartItem == nil {
		newCartItem := &models.CartItem{
			CartID:    cartID,
			ProductID: productID,
			Quantity:  quantity,
		}
		return u.cartItemRepo.CreateCartItem(newCartItem)
	}

	cartItem.Quantity += quantity
	return u.cartItemRepo.UpdateCartItem(cartItem)
}

func (u *cartItemUsecase) CalculateCartTotal(cartID uint) (float64, error) {
	return u.cartItemRepo.CalculateCartTotal(cartID)
}
