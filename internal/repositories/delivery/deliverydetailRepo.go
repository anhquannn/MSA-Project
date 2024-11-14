package delivery

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type DeliveryDetailRepository interface {
	CreateDeliveryDetail(deliverydetail *models.DeliveryDetails) error
	DeleteDeliveryDetail(deliverydetail *models.DeliveryDetails) error
	UpdateDeliveryDetail(deliverydetail *models.DeliveryDetails) error

	GetDeliveryDetailByID(id uint) (*models.DeliveryDetails, error)
}

type deliveryDetailRepository struct {
	db *gorm.DB
}

func NewDeliveryDetailRepository(db *gorm.DB) DeliveryDetailRepository {
	return &deliveryDetailRepository{db}
}

func (r *deliveryDetailRepository) CreateDeliveryDetail(deliverydetail *models.DeliveryDetails) error {
	return r.db.Create(deliverydetail).Error
}

func (r *deliveryDetailRepository) DeleteDeliveryDetail(deliverydetail *models.DeliveryDetails) error {
	return r.db.Model(&models.DeliveryDetails{}).Where("id = ?", deliverydetail.ID).Delete(deliverydetail).Error
}

func (r *deliveryDetailRepository) UpdateDeliveryDetail(deliverydetail *models.DeliveryDetails) error {
	return r.db.Save(deliverydetail).Error
}

func (r *deliveryDetailRepository) GetDeliveryDetailByID(id uint) (*models.DeliveryDetails, error) {
	var deliveydetail models.DeliveryDetails
	err := r.db.First(&deliveydetail, id).Error
	return &deliveydetail, err
}
