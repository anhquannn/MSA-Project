package product

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type ProductRepository interface {
	CreateProduct(product *models.Product) error
	DeleteProduct(product *models.Product) error
	UpdateProduct(product *models.Product) error

	GetProductByID(id uint) (*models.Product, error)
	GetAllProducts(page, pageSize int) ([]models.Product, error)
	SearchProductsByName(name string, page, pageSize int) ([]models.Product, error)
	FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint, page, pageSize int) ([]models.Product, error)
}

type productRepository struct {
	db *gorm.DB
}

func NewProductRepository(db *gorm.DB) ProductRepository {
	return &productRepository{db}
}

func (r *productRepository) CreateProduct(product *models.Product) error {
	return r.db.Create(product).Error
}

func (r *productRepository) DeleteProduct(product *models.Product) error {
	return r.db.Delete(product).Error
}

func (r *productRepository) UpdateProduct(product *models.Product) error {
	return r.db.Save(product).Error
}

func (r *productRepository) GetProductByID(id uint) (*models.Product, error) {
	var product models.Product
	if err := r.db.First(&product, id).Error; err != nil {
		return nil, err
	}
	return &product, nil
}

func (r *productRepository) GetAllProducts(page, pageSize int) ([]models.Product, error) {
	var products []models.Product
	err := r.db.Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&products).Error
	return products, err
}

func (r *productRepository) SearchProductsByName(name string, page, pageSize int) ([]models.Product, error) {
	var products []models.Product
	err := r.db.Where("name LIKE ?", "%"+name+"%").
		Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&products).Error
	return products, err
}

func (r *productRepository) FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint, page, pageSize int) ([]models.Product, error) {
	var products []models.Product
	query := r.db.Where("1=1")

	if size > 0 {
		query = query.Where("size = ?", size)
	}
	if minPrice >= 0 {
		query = query.Where("price >= ?", minPrice)
	}
	if maxPrice > 0 {
		query = query.Where("price <= ?", maxPrice)
	}
	if color != "" {
		query = query.Where("color = ?", color)
	}
	if categoryID > 0 {
		query = query.Where("category_id = ?", categoryID)
	}

	query = query.Order("sales DESC").
		Limit(pageSize).
		Offset((page - 1) * pageSize)

	err := query.Find(&products).Error
	return products, err
}
