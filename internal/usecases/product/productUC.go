package product

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/product"
	"errors"
)

type ProductUsecase interface {
	CreateProduct(product *models.Product) error
	UpdateProduct(product *models.Product) error
	DeleteProduct(product *models.Product) error

	GetProductByID(id uint) (*models.Product, error)
	GetAllProducts() ([]models.Product, error)
	SearchProductsByName(name string) ([]models.Product, error)
	FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint) ([]models.Product, error)
	UpdateStockNumber(productID uint, quantity int) error
}

type productUsecase struct {
	productRepo product.ProductRepository
}

func NewProductUsecase(productRepo product.ProductRepository) ProductUsecase {
	return &productUsecase{productRepo}
}

func (u *productUsecase) CreateProduct(product *models.Product) error {
	return u.productRepo.CreateProduct(product)
}

func (u *productUsecase) UpdateProduct(product *models.Product) error {
	return u.productRepo.UpdateProduct(product)
}

func (u *productUsecase) DeleteProduct(product *models.Product) error {
	return u.productRepo.DeleteProduct(product)
}

func (u *productUsecase) GetProductByID(id uint) (*models.Product, error) {
	return u.productRepo.GetProductByID(id)
}

func (u *productUsecase) GetAllProducts() ([]models.Product, error) {
	return u.productRepo.GetAllProducts()
}

func (u *productUsecase) SearchProductsByName(name string) ([]models.Product, error) {
	return u.productRepo.SearchProductsByName(name)
}

func (u *productUsecase) FilterAndSortProducts(size int, minPrice, maxPrice float64, color string, categoryID uint) ([]models.Product, error) {
	return u.productRepo.FilterAndSortProducts(size, minPrice, maxPrice, color, categoryID)
}

func (u *productUsecase) UpdateStockNumber(productID uint, quantity int) error {
	product, err := u.productRepo.GetProductByID(productID)
	if err != nil {
		return err
	}

	product.StockNumber -= quantity
	if product.StockNumber < 0 {
		return errors.New("insufficient stock")
	}

	switch {
	case product.StockNumber > 300:
		product.StockLevel = "high"
	case product.StockNumber > 50:
		product.StockLevel = "medium"
	default:
		product.StockLevel = "low"
	}

	return u.productRepo.UpdateProduct(product)
}
