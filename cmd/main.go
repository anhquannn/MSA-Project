package main

import (
	config "MSA-Project/internal/configdev"
	interfaces "MSA-Project/internal/interfaces/http"
	repoProduct "MSA-Project/internal/repositories/product"
	repoUser "MSA-Project/internal/repositories/user"
	svs "MSA-Project/internal/services"
	ucProduct "MSA-Project/internal/usecases/product"
	ucUser "MSA-Project/internal/usecases/user"
	"log"

	"github.com/gin-gonic/gin"
)

func main() {
	config.ConnectDatabase()

	//User
	userRepo := repoUser.NewUserRepository(config.DB)
	emailService := svs.NewEmailService()
	userUsecase := ucUser.NewUserUsecase(userRepo, emailService)
	userHandler := interfaces.NewUserHandler(userUsecase, emailService)

	//Product
	productRepo := repoProduct.NewProductRepository(config.DB)
	productUsecase := ucProduct.NewProductUsecase(productRepo)
	productHandler := interfaces.NewProductHandler(productUsecase)

	// Product Detail
	productDetailRepo := repoProduct.NewProductDetailRepository(config.DB)
	productDetailUsecase := ucProduct.NewProductDetailUsecase(productDetailRepo)
	productDetailHandler := interfaces.NewProductDetailHandler(productDetailUsecase)

	// Manufacturer
	manufacturerRepo := repoProduct.NewManufacturerRepository(config.DB)
	manufacturerUsecase := ucProduct.NewManufacturerUsecase(manufacturerRepo)
	manufacturerHandler := interfaces.NewManufacturerHandler(manufacturerUsecase)

	// Category
	categoryRepo := repoProduct.NewCategoryRepository(config.DB)
	categoryUsecase := ucProduct.NewCategoryUsecase(categoryRepo)
	categoryHandler := interfaces.NewCategoryHandler(categoryUsecase)

	router := gin.Default()

	config.UserRoutes(router, userHandler)
	config.ProductRoutes(router, productHandler)
	config.ProductDetailRoutes(router, productDetailHandler)
	config.ManufacturerRoutes(router, manufacturerHandler)
	config.CategoryRoutes(router, categoryHandler)

	log.Println("Server started at :8080")
	router.Run(":8080")
}
