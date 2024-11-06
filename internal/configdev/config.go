package config

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/interfaces/http"
	"MSA-Project/internal/utils"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var DB *gorm.DB

func ConnectDatabase() {
	database, err := gorm.Open(sqlite.Open("msa.db"), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database!")
		os.Exit(1)
	}

	database.AutoMigrate(&models.User{}, &models.Product{}, &models.Manufacturer{}, &models.Category{}, &models.Cart{},
		&models.CartItem{}, &models.Delivery{}, &models.DeliveryDetails{}, &models.Feedback{}, &models.Payment{},
		&models.Order{}, &models.OrderDetail{}, &models.OrderPromoCode{}, &models.PromoCode{}, &models.ReturnOrder{})

	DB = database
}

func UserRoutes(router *gin.Engine, userHandler http.UserHandler) {
	users := router.Group("/users")
	{
		users.POST("/register", userHandler.RegisterUser)
		users.POST("/login", userHandler.Login)
		users.POST("/verify", userHandler.VerifyOTP)
		users.POST("/login/google", userHandler.LoginWithGoogle)
		users.POST("/resetpass", userHandler.GetNewPassword)

		secured := users.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.DELETE("/:id", userHandler.DeleteUser)
			secured.PUT("/:id/password", userHandler.UpdateUser)
			secured.PUT("/:id", userHandler.UpdateUserInf)
			secured.GET("/:id", userHandler.GetUserById)
			secured.GET("/phone/:phone", userHandler.GetUserByPhoneNumber)
		}
	}
}

func ProductRoutes(router *gin.Engine, productHandler http.ProductHandler) {
	products := router.Group("/products")
	{
		products.GET("/", productHandler.GetAllProducts)
		products.GET("/:id", productHandler.GetProductByID)
		products.GET("/search", productHandler.SearchProducts)
		products.GET("/filter", productHandler.FilterAndSortProducts)

		secured := products.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", productHandler.CreateProduct)
			secured.PUT("/:id", productHandler.UpdateProduct)
			secured.DELETE("/:id", productHandler.DeleteProduct)
		}
	}
}

func CategoryRoutes(router *gin.Engine, categoryHandler http.CategoryHandler) {
	categories := router.Group("/categories")
	{
		categories.GET("/", categoryHandler.GetAllCategories)
		categories.GET("/:id", categoryHandler.GetCategoryByID)

		secured := categories.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", categoryHandler.CreateCategory)
			secured.PUT("/:id", categoryHandler.UpdateCategory)
			secured.DELETE("/:id", categoryHandler.DeleteCategory)
		}
	}
}

func ManufacturerRoutes(router *gin.Engine, manufacturerHandler http.ManufacturerHandler) {
	manufacturers := router.Group("/manufacturers")
	{
		manufacturers.GET("/", manufacturerHandler.GetAllManufacturers)
		manufacturers.GET("/:id", manufacturerHandler.GetManufacturerByID)

		secured := manufacturers.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.PUT("/:id", manufacturerHandler.UpdateManufacturer)
			secured.DELETE("/:id", manufacturerHandler.DeleteManufacturer)
			secured.POST("/", manufacturerHandler.CreateManufacturer)
		}
	}
}

func CartRoutes(router *gin.Engine, cartHandler http.CartHandler) {
	carts := router.Group("/cart")
	{

		secured := carts.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", cartHandler.CreateCart)
			secured.POST("/:userID", cartHandler.GetOrCreateCartForUser)
			secured.PUT("/:id", cartHandler.UpdateCart)
			secured.DELETE("/:id", cartHandler.DeleteCart)
			secured.GET("/:id", cartHandler.GetCartByID)
		}
	}
}

func CartItemRoutes(router *gin.Engine, cartitemHandler http.CartItemHandler) {
	cartitems := router.Group("/cartitem")
	{
		secured := cartitems.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/addproduct", cartitemHandler.AddProductToCart)
			secured.POST("/clearcart", cartitemHandler.ClearCart)
			secured.PUT("/:id", cartitemHandler.UpdateCartItem)
			secured.DELETE("/:id", cartitemHandler.DeleteCartItem)
			secured.GET("/:id", cartitemHandler.GetCartItemByID)
			secured.GET("/carts/:id", cartitemHandler.GetCartItemsByCartID)
		}
	}
}

func OrderDetailRoutes(router *gin.Engine, orderdetailHandler http.OrderDetailHandler) {
	orderdetails := router.Group("/oderdetail")
	{
		secured := orderdetails.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", orderdetailHandler.CreateOrderDetail)
			secured.PUT("/:id", orderdetailHandler.UpdateOrderDetail)
			secured.DELETE("/:id", orderdetailHandler.DeleteOrderDetail)
			secured.GET("/:id", orderdetailHandler.GetOrderDetailByID)
		}
	}
}

func OrderRoutes(router *gin.Engine, orderHandler http.OrderHandler) {
	orders := router.Group("/order")
	{
		secured := orders.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", orderHandler.CreateOrder)
			secured.PUT("/:id", orderHandler.UpdateOrder)
			secured.DELETE("/:id", orderHandler.DeleteOrder)
			secured.GET("/:id", orderHandler.GetOrderByID)
			secured.GET("/", orderHandler.GetAllOrders)
			secured.GET("/search", orderHandler.SearchOrderByPhoneNumber)
		}
	}
}

func PromoCodeRoutes(router *gin.Engine, promoCodeHandler http.PromoCodeHandler) {
	promocodes := router.Group("/promocode")
	{
		promocodes.GET("/:id", promoCodeHandler.GetPromoCodeByID)

		secured := promocodes.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", promoCodeHandler.CreatePromoCode)
			secured.PUT("/:id", promoCodeHandler.UpdatePromoCode)
			secured.DELETE("/:id", promoCodeHandler.DeletePromoCode)
		}
	}
}

func FeedbackRoutes(router *gin.Engine, feedbackHandler http.FeedbackHandler) {
	feedbacks := router.Group("/feedback")
	{
		feedbacks.GET("/:id", feedbackHandler.GetFeedbackByID)

		secured := feedbacks.Group("/")
		secured.Use(utils.AuthRequired())
		{
			secured.POST("/", feedbackHandler.CreateFeedback)
			secured.PUT("/:id", feedbackHandler.UpdateFeedback)
			secured.DELETE("/:id", feedbackHandler.DeleteFeedback)
			secured.GET("/product/:id", feedbackHandler.GetAllFeedbacksByProductID)
		}
	}
}
