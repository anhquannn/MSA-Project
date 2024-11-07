package http

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/domain/requests"
	"MSA-Project/internal/usecases/product"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type productDetailHandler struct {
	productDetailUsecase product.ProductDetailUsecase
}

type ProductDetailHandler interface {
	CreateProductDetail(c *gin.Context)
	UpdateProductDetail(c *gin.Context)
	DeleteProductDetail(c *gin.Context)

	GetProductDetailByID(c *gin.Context)
}

func NewProductDetailHandler(pdu product.ProductDetailUsecase) ProductDetailHandler {
	return &productDetailHandler{
		productDetailUsecase: pdu,
	}
}

func (h *productDetailHandler) CreateProductDetail(c *gin.Context) {
	var reqProductDetail requests.ProductDetail
	if err := c.ShouldBindJSON(&reqProductDetail); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	productDetail := models.ProductDetail{
		ProductID: reqProductDetail.ProductID,

		Description:   reqProductDetail.Description,
		Specification: reqProductDetail.Specification,
		Size:          reqProductDetail.Size,
		Color:         reqProductDetail.Color,
		Expiry:        reqProductDetail.Expiry,
		StockNumber:   reqProductDetail.StockNumber,
		StockLevel:    reqProductDetail.StockLevel,
	}

	if err := h.productDetailUsecase.CreateProductDetail(&productDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, productDetail)
}

func (h *productDetailHandler) UpdateProductDetail(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	productDetail, err := h.productDetailUsecase.GetProductDetailByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	var reqProductDetail requests.ProductDetail
	if err := c.ShouldBindJSON(&reqProductDetail); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	productDetail.ProductID = reqProductDetail.ProductID

	productDetail.Description = reqProductDetail.Description
	productDetail.Specification = reqProductDetail.Specification
	productDetail.Size = reqProductDetail.Size
	productDetail.Color = reqProductDetail.Color
	productDetail.Expiry = reqProductDetail.Expiry
	productDetail.StockNumber = reqProductDetail.StockNumber
	productDetail.StockLevel = reqProductDetail.StockLevel

	if err := h.productDetailUsecase.UpdateProductDetail(productDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, productDetail)
}

func (h *productDetailHandler) DeleteProductDetail(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	productDetail := models.ProductDetail{}
	productDetail.ID = uint(id)

	if err := h.productDetailUsecase.DeleteProductDetail(&productDetail); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "Product detail deleted"})
}

func (h *productDetailHandler) GetProductDetailByID(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	productDetail, err := h.productDetailUsecase.GetProductDetailByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, productDetail)
}
