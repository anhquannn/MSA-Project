package main

import (
	config "MSA-Project/internal/configdev"
	interfaces "MSA-Project/internal/interfaces/http"

	repoCart "MSA-Project/internal/repositories/cart"
	repoOrder "MSA-Project/internal/repositories/order"
	repoProduct "MSA-Project/internal/repositories/product"
	repoUser "MSA-Project/internal/repositories/user"

	svs "MSA-Project/internal/services"

	ucCart "MSA-Project/internal/usecases/cart"
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

	//Cart
	cartRepo := repoCart.NewCartRepository(config.DB)
	cartUsecase := ucCart.NewCartUsecase(cartRepo)
	cartHandler := interfaces.NewCartHandler(cartUsecase)

	//CartItem
	cartItemRepo := repoCart.NewCartItemRepository(config.DB)
	cartItemUsecase := ucCart.NewCartItemUsecase(cartItemRepo)
	cartItemHandler := interfaces.NewCartItemHandler(cartItemUsecase)

	//Promocode
	promoCodeRepo := repoOrder.NewPromoCodeRepository(config.DB)
	promoCodeUsecase := ucOrder.NewPromoCodeUsecase(promoCodeRepo)
	promoCodeHandler := interfaces.NewPromoCodeHandler(promoCodeUsecase)

	//Feedback
	feedbackRepo := repoOrder.NewFeedbackRepository(config.DB)
	feedbackUsecase := ucOrder.NewFeedbackUsecase(feedbackRepo)
	feedbackHandler := interfaces.NewFeedbackHandler(feedbackUsecase)

	//OrderDetail
	orderDetailRepo := repoOrder.NewOrderDetailRepository(config.DB)
	orderDetailUsecase := ucOrder.NewOrderDetailUsecase(orderDetailRepo)
	orderDetailHandler := interfaces.NewOrderDetailHandler(orderDetailUsecase)

	//Order
	orderRepo := repoOrder.NewOrderRepository(config.DB)
	orderUsecase := ucOrder.NewOrderUsecase(orderRepo, cartUsecase, cartItemUsecase, promoCodeUsecase, orderDetailUsecase, productUsecase)
	orderHandler := interfaces.NewOrderHandler(orderUsecase)

	router := gin.Default()

	config.UserRoutes(router, userHandler)
	config.ProductRoutes(router, productHandler)
	config.ManufacturerRoutes(router, manufacturerHandler)
	config.CategoryRoutes(router, categoryHandler)
	config.CartRoutes(router, cartHandler)
	config.CartItemRoutes(router, cartItemHandler)
	config.OrderRoutes(router, orderHandler)
	config.OrderDetailRoutes(router, orderDetailHandler)
	config.PromoCodeRoutes(router, promoCodeHandler)
	config.FeedbackRoutes(router, feedbackHandler)

	log.Println("Server started at :8080")
	router.Run(":8080")
}
