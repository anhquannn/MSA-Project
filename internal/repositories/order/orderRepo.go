package order

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type OrderRepository interface {
	CreateOrder(order *models.Order) error
	DeleteOrder(order *models.Order) error
	UpdateOrder(order *models.Order) error

	GetAllOrders(page, pageSize int) ([]models.Order, error)
	SearchOrderByPhoneNumber(phoneNumber string, page, pageSize int) ([]models.Order, error)
	GetOrderByID(id uint) (*models.Order, error)
	GetOrderWithDetails(orderID uint) (*models.Order, error)
}

type orderRepository struct {
	db *gorm.DB
}

func NewOrderRepository(db *gorm.DB) OrderRepository {
	return &orderRepository{db}
}

func (r *orderRepository) CreateOrder(order *models.Order) error {
	return r.db.Create(order).Error
}

func (r *orderRepository) DeleteOrder(order *models.Order) error {
	return r.db.Model(&models.Order{}).Where("id = ?", order.ID).Delete(order).Error
}

func (r *orderRepository) UpdateOrder(order *models.Order) error {
	return r.db.Save(order).Error
}

func (r *orderRepository) GetAllOrders(page, pageSize int) ([]models.Order, error) {
	var orders []models.Order
	err := r.db.Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&orders).Error
	return orders, err
}

func (r *orderRepository) SearchOrderByPhoneNumber(phoneNumber string, page, pageSize int) ([]models.Order, error) {
	var orders []models.Order
	err := r.db.Joins("User").
		Where("users.phone_number = ?", phoneNumber).
		Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&orders).Error
	return orders, err
}

func (r *orderRepository) GetOrderByID(id uint) (*models.Order, error) {
	var order models.Order
	err := r.db.First(&order, id).Error
	return &order, err
}

func (r *orderRepository) GetOrderWithDetails(orderID uint) (*models.Order, error) {
	var order models.Order
	if err := r.db.Preload("User").
		Preload("Cart").
		Preload("Cart.User").
		First(&order, orderID).Error; err != nil {
		return nil, err
	}
	return &order, nil
}
