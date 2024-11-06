package order

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/order"
	"MSA-Project/internal/usecases/cart"
	"MSA-Project/internal/usecases/product"
	"errors"
)

type OrderUsecase interface {
	CreateOrder(userID uint, cartID uint, promoCode string) (*models.Order, error)
	UpdateOrder(order *models.Order) error
	DeleteOrder(order *models.Order) error

	GetOrderByID(id uint) (*models.Order, error)
	SearchOrderByPhoneNumber(phoneNumber string) ([]models.Order, error)
	GetAllOrders() ([]models.Order, error)
}

type orderUsecase struct {
	orderRepo          order.OrderRepository
	cartUsecase        cart.CartUsecase
	cartItemUsecase    cart.CartItemUsecase
	promoCodeUsecase   PromoCodeUsecase
	orderDetailUsecase OrderDetailUsecase
	productUsecase     product.ProductUsecase
}

func NewOrderUsecase(
	orderRepo order.OrderRepository,
	cartUsecase cart.CartUsecase,
	cartItemUsecase cart.CartItemUsecase,
	promoCodeUsecase PromoCodeUsecase,
	orderDetailUsecase OrderDetailUsecase,
	productUsecase product.ProductUsecase,
) OrderUsecase {
	return &orderUsecase{
		orderRepo:          orderRepo,
		cartUsecase:        cartUsecase,
		cartItemUsecase:    cartItemUsecase,
		promoCodeUsecase:   promoCodeUsecase,
		orderDetailUsecase: orderDetailUsecase,
		productUsecase:     productUsecase,
	}
}

func (u *orderUsecase) CreateOrder(userID uint, cartID uint, promoCode string) (*models.Order, error) {
	cart, err := u.cartUsecase.GetCartByID(cartID)
	if err != nil || cart.UserID != userID {
		return nil, errors.New("cart not found or does not belong to the user")
	}

	totalCost, err := u.cartItemUsecase.CalculateCartTotal(cartID)
	if err != nil {
		return nil, errors.New("calculate cart total failed")
	}

	if promoCode != "" {
		promo, err := u.promoCodeUsecase.GetPromoCodeByCode(promoCode)
		if err == nil && totalCost >= promo.MinimumOrderValue {
			discountAmount := totalCost * (promo.DiscountPercentage / 100)
			totalCost -= discountAmount
		}
	}

	order := &models.Order{
		UserID:     userID,
		CartID:     cartID,
		GrandTotal: totalCost,
		Status:     "pending",
	}

	if err := u.orderRepo.CreateOrder(order); err != nil {
		return nil, err
	}

	cartItems, err := u.cartItemUsecase.GetCartItemsByCartID(cartID)
	if err != nil {
		return nil, err
	}

	for _, cartItem := range cartItems {
		orderDetail := &models.OrderDetail{
			OrderID:    order.ID,
			ProductID:  cartItem.ProductID,
			Quantity:   cartItem.Quantity,
			UnitPrice:  cartItem.Product.Price,
			TotalPrice: float64(cartItem.Quantity) * cartItem.Product.Price,
		}
		if err := u.orderDetailUsecase.CreateOrderDetail(orderDetail); err != nil {
			return nil, err
		}

		if err := u.productUsecase.UpdateStockNumber(cartItem.ProductID, cartItem.Quantity); err != nil {
			return nil, err
		}
	}

	if err := u.cartItemUsecase.ClearCart(cartID); err != nil {
		return nil, err
	}

	return order, nil
}

func (u *orderUsecase) UpdateOrder(order *models.Order) error {
	return u.orderRepo.UpdateOrder(order)
}

func (u *orderUsecase) DeleteOrder(order *models.Order) error {
	return u.orderRepo.DeleteOrder(order)
}

func (u *orderUsecase) GetOrderByID(id uint) (*models.Order, error) {
	return u.orderRepo.GetOrderByID(id)
}

func (u *orderUsecase) SearchOrderByPhoneNumber(phoneNumber string) ([]models.Order, error) {
	return u.orderRepo.SearchOrderByPhoneNumber(phoneNumber)
}

func (u *orderUsecase) GetAllOrders() ([]models.Order, error) {
	return u.orderRepo.GetAllOrders()
}
