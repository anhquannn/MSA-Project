package main

import (
	config "MSA-Project/internal/configdev"
	interfaces "MSA-Project/internal/interfaces/http"
	repoOrder "MSA-Project/internal/repositories/order"
	repoProduct "MSA-Project/internal/repositories/product"
	repoUser "MSA-Project/internal/repositories/user"
	svs "MSA-Project/internal/services"
	ucOrder "MSA-Project/internal/usecases/order"
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

	// Manufacturer
	manufacturerRepo := repoProduct.NewManufacturerRepository(config.DB)
	manufacturerUsecase := ucProduct.NewManufacturerUsecase(manufacturerRepo)
	manufacturerHandler := interfaces.NewManufacturerHandler(manufacturerUsecase)

	// Category
	categoryRepo := repoProduct.NewCategoryRepository(config.DB)
	categoryUsecase := ucProduct.NewCategoryUsecase(categoryRepo)
	categoryHandler := interfaces.NewCategoryHandler(categoryUsecase)

	//Promocode
	promoCodeRepo := repoOrder.NewPromoCodeRepository(config.DB)
	promoCodeUsecase := ucOrder.NewPromoCodeUsecase(promoCodeRepo)
	promoCodeHandler := interfaces.NewPromoCodeHandler(promoCodeUsecase)

	//Feedback
	feedbackRepo := repoOrder.NewFeedbackRepository(config.DB)
	feedbackUsecase := ucOrder.NewFeedbackUsecase(feedbackRepo)
	feedbackHandler := interfaces.NewFeedbackHandler(feedbackUsecase)

	router := gin.Default()

	config.UserRoutes(router, userHandler)
	config.ProductRoutes(router, productHandler)
	config.ManufacturerRoutes(router, manufacturerHandler)
	config.CategoryRoutes(router, categoryHandler)
	config.PromoCodeRoutes(router, promoCodeHandler)
	config.FeedbackRoutes(router, feedbackHandler)

	log.Println("Server started at :8080")
	router.Run(":8080")
}
