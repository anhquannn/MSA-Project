package product

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type ProductDetailRepository interface {
	CreateProductDetail(detail *models.ProductDetail) error
	DeleteProductDetail(detail *models.ProductDetail) error
	UpdateProductDetail(detail *models.ProductDetail) error

	GetProductDetailByID(id uint) (*models.ProductDetail, error)
}

type productDetailRepository struct {
	db *gorm.DB
}

func NewProductDetailRepository(db *gorm.DB) ProductDetailRepository {
	return &productDetailRepository{db}
}

func (r *productDetailRepository) CreateProductDetail(detail *models.ProductDetail) error {
	return r.db.Create(detail).Error
}

func (r *productDetailRepository) DeleteProductDetail(detail *models.ProductDetail) error {
	return r.db.Delete(detail).Error
}

func (r *productDetailRepository) UpdateProductDetail(detail *models.ProductDetail) error {
	return r.db.Save(detail).Error
}

func (r *productDetailRepository) GetProductDetailByID(id uint) (*models.ProductDetail, error) {
	var detail models.ProductDetail
	if err := r.db.First(&detail, id).Error; err != nil {
		return nil, err
	}
	return &detail, nil
}

