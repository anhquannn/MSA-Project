package order

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type OrderDetailRepository interface {
	CreateOrderDetail(orderDetail *models.OrderDetail) error
	DeleteOrderDetail(orderDetail *models.OrderDetail) error
	UpdateOrderDetail(orderDetail *models.OrderDetail) error
	GetOrderDetailByID(id uint) (*models.OrderDetail, error)
}

type orderDetailRepository struct {
	db *gorm.DB
}

func NewOrderDetailRepository(db *gorm.DB) OrderDetailRepository {
	return &orderDetailRepository{db}
}

func (r *orderDetailRepository) CreateOrderDetail(orderDetail *models.OrderDetail) error {
	return r.db.Create(orderDetail).Error
}

func (r *orderDetailRepository) DeleteOrderDetail(orderDetail *models.OrderDetail) error {
	return r.db.Model(&models.OrderDetail{}).Where("id = ?", orderDetail.ID).Delete(orderDetail).Error
}

func (r *orderDetailRepository) UpdateOrderDetail(orderDetail *models.OrderDetail) error {
	return r.db.Save(orderDetail).Error
}

func (r *orderDetailRepository) GetOrderDetailByID(id uint) (*models.OrderDetail, error) {
	var orderDetail models.OrderDetail
	err := r.db.First(&orderDetail, id).Error
	return &orderDetail, err
}
