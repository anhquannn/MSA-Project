package main

import (
	config "MSA-Project/internal/configdev"
	interfaces "MSA-Project/internal/interfaces/http"
	repoUser "MSA-Project/internal/repositories/user"
	svs "MSA-Project/internal/services"
	ucUser "MSA-Project/internal/usecases/user"
	"log"

	"github.com/gin-gonic/gin"
)

func main() {
	config.ConnectDatabase()

	userRepo := repoUser.NewUserRepository(config.DB)

	emailService := svs.NewEmailService()

	userUsecase := ucUser.NewUserUsecase(userRepo, emailService)

	userHandler := interfaces.NewUserHandler(userUsecase, emailService)

	router := gin.Default()

	config.UserRoutes(router, userHandler)

	log.Println("Server started at :8080")
	router.Run(":8080")
}
