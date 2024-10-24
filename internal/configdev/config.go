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

	database.AutoMigrate(&models.User{})

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
