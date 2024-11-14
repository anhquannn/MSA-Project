package order

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type ReturnOrderRepository interface {
	CreateReturnOrder(returnOrder *models.ReturnOrder) error
	DeleteReturnOrder(returnOrder *models.ReturnOrder) error
	UpdateReturnOrder(returnOrder *models.ReturnOrder) error
	GetReturnOrderByID(id uint) (*models.ReturnOrder, error)
}

type returnOrderRepository struct {
	db *gorm.DB
}

func NewReturnOrderRepository(db *gorm.DB) ReturnOrderRepository {
	return &returnOrderRepository{db}
}

func (r *returnOrderRepository) CreateReturnOrder(returnOrder *models.ReturnOrder) error {
	return r.db.Create(returnOrder).Error
}

func (r *returnOrderRepository) DeleteReturnOrder(returnOrder *models.ReturnOrder) error {
	return r.db.Model(&models.ReturnOrder{}).Where("id = ?", returnOrder.ID).Delete(returnOrder).Error
}

func (r *returnOrderRepository) UpdateReturnOrder(returnOrder *models.ReturnOrder) error {
	return r.db.Save(returnOrder).Error
}

func (r *returnOrderRepository) GetReturnOrderByID(id uint) (*models.ReturnOrder, error) {
	var returnOrder models.ReturnOrder
	err := r.db.First(&returnOrder, id).Error
	return &returnOrder, err
}
