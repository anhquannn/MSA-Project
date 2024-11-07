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

	database.AutoMigrate(&models.User{}, &models.Product{}, &models.Manufacturer{}, &models.ProductDetail{}, &models.Category{})

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
			products.POST("/", productHandler.CreateProduct)
			products.PUT("/:id", productHandler.UpdateProduct)
			products.DELETE("/:id", productHandler.DeleteProduct)
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
			categories.POST("/", categoryHandler.CreateCategory)
			categories.PUT("/:id", categoryHandler.UpdateCategory)
			categories.DELETE("/:id", categoryHandler.DeleteCategory)
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
			manufacturers.PUT("/:id", manufacturerHandler.UpdateManufacturer)
			manufacturers.DELETE("/:id", manufacturerHandler.DeleteManufacturer)
			manufacturers.POST("/", manufacturerHandler.CreateManufacturer)
		}
	}
}

func ProductDetailRoutes(router *gin.Engine, productDetailHandler http.ProductDetailHandler) {
	productDetails := router.Group("/product-details")
	{
		productDetails.GET("/:id", productDetailHandler.GetProductDetailByID)

		secured := productDetails.Group("/")
		secured.Use(utils.AuthRequired())
		{
			productDetails.POST("/", productDetailHandler.CreateProductDetail)
			productDetails.PUT("/:id", productDetailHandler.UpdateProductDetail)
			productDetails.DELETE("/:id", productDetailHandler.DeleteProductDetail)
		}
	}
}
