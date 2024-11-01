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
	GetAllProducts() ([]models.Product, error)
	SearchProductsByName(name string) ([]models.Product, error)
	FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint) ([]models.Product, error)
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

func (r *productRepository) GetAllProducts() ([]models.Product, error) {
	var products []models.Product
	if err := r.db.Find(&products).Error; err != nil {
		return nil, err
	}
	return products, nil
}

func (r *productRepository) SearchProductsByName(name string) ([]models.Product, error) {
	var products []models.Product
	if err := r.db.Where("name LIKE ?", "%"+name+"%").Find(&products).Error; err != nil {
		return nil, err
	}
	return products, nil
}

func (r *productRepository) FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint) ([]models.Product, error) {
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

	// Ordering by popularity (based on number of associated order details)
	query = query.Order(`(
		SELECT COUNT(*)
		FROM order_details
		WHERE order_details.product_id = products.id
	) DESC`)

	if err := query.Find(&products).Error; err != nil {
		return nil, err
	}

	return products, nil
}
