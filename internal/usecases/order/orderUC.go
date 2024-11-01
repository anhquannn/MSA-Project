package order

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/order"
)

type OrderUsecase interface {
	CreateOrder(order *models.Order) error
	UpdateOrder(order *models.Order) error
	DeleteOrder(order *models.Order) error

	GetOrderByID(id uint) (*models.Order, error)
}

type orderUsecase struct {
	orderRepo order.OrderRepository
}

func NewOrderUsecase(orderRepo order.OrderRepository) OrderUsecase {
	return &orderUsecase{orderRepo}
}

func (u *orderUsecase) CreateOrder(order *models.Order) error {
	return u.orderRepo.CreateOrder(order)
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
