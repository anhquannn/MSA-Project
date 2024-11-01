package http

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/domain/requests"
	"MSA-Project/internal/usecases/order"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type promoCodeHandler struct {
	promoCodeUsecase order.PromoCodeUsecase
}

type PromoCodeHandler interface {
	CreatePromoCode(c *gin.Context)
	UpdatePromoCode(c *gin.Context)
	DeletePromoCode(c *gin.Context)
	GetPromoCodeByID(c *gin.Context)
}

func NewPromoCodeHandler(pu order.PromoCodeUsecase) PromoCodeHandler {
	return &promoCodeHandler{
		promoCodeUsecase: pu,
	}
}

func (h *promoCodeHandler) CreatePromoCode(c *gin.Context) {
	var reqPromoCode requests.PromoCode
	if err := c.ShouldBindJSON(&reqPromoCode); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	promoCode := models.PromoCode{
		Name:              reqPromoCode.Name,
		Code:              reqPromoCode.Code,
		Description:       reqPromoCode.Description,
		StartDate:         reqPromoCode.StartDate,
		EndDate:           reqPromoCode.EndDate,
		Status:            reqPromoCode.Status,
		DiscountType:      reqPromoCode.DiscountType,
		DiscountValue:     reqPromoCode.DiscountValue,
		MinimumOrderValue: reqPromoCode.MinimumOrderValue,
	}

	if err := h.promoCodeUsecase.CreatePromoCode(&promoCode); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, promoCode)
}

func (h *promoCodeHandler) UpdatePromoCode(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	promoCode, err := h.promoCodeUsecase.GetPromoCodeByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	var reqPromoCode requests.PromoCode
	if err := c.ShouldBindJSON(&reqPromoCode); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	promoCode.Name = reqPromoCode.Name
	promoCode.Code = reqPromoCode.Code
	promoCode.Description = reqPromoCode.Description
	promoCode.StartDate = reqPromoCode.StartDate
	promoCode.EndDate = reqPromoCode.EndDate
	promoCode.Status = reqPromoCode.Status
	promoCode.DiscountType = reqPromoCode.DiscountType
	promoCode.DiscountValue = reqPromoCode.DiscountValue
	promoCode.MinimumOrderValue = reqPromoCode.MinimumOrderValue

	if err := h.promoCodeUsecase.UpdatePromoCode(promoCode); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, promoCode)
}

func (h *promoCodeHandler) DeletePromoCode(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	promoCode := models.PromoCode{}
	promoCode.ID = uint(id)

	if err := h.promoCodeUsecase.DeletePromoCode(&promoCode); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "Promo code deleted"})
}

func (h *promoCodeHandler) GetPromoCodeByID(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	promoCode, err := h.promoCodeUsecase.GetPromoCodeByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, promoCode)
}
