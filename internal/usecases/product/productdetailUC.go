package product

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/product"
)

type ProductDetailUsecase interface {
	CreateProductDetail(productDetail *models.ProductDetail) error
	UpdateProductDetail(productDetail *models.ProductDetail) error
	DeleteProductDetail(productDetail *models.ProductDetail) error

	GetProductDetailByID(id uint) (*models.ProductDetail, error)
}

type productDetailUsecase struct {
	productDetailRepo product.ProductDetailRepository
}

func NewProductDetailUsecase(productDetailRepo product.ProductDetailRepository) ProductDetailUsecase {
	return &productDetailUsecase{productDetailRepo}
}

func (u *productDetailUsecase) CreateProductDetail(productDetail *models.ProductDetail) error {
	return u.productDetailRepo.CreateProductDetail(productDetail)
}

func (u *productDetailUsecase) UpdateProductDetail(productDetail *models.ProductDetail) error {
	return u.productDetailRepo.UpdateProductDetail(productDetail)
}

func (u *productDetailUsecase) DeleteProductDetail(productDetail *models.ProductDetail) error {
	return u.productDetailRepo.DeleteProductDetail(productDetail)
}

func (u *productDetailUsecase) GetProductDetailByID(id uint) (*models.ProductDetail, error) {
	return u.productDetailRepo.GetProductDetailByID(id)
}
