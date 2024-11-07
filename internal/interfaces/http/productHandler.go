package http

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/domain/requests"
	"MSA-Project/internal/usecases/product"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type productHandler struct {
	productUsecase product.ProductUsecase
}

type ProductHandler interface {
	CreateProduct(c *gin.Context)
	UpdateProduct(c *gin.Context)
	DeleteProduct(c *gin.Context)

	GetProductByID(c *gin.Context)
	GetAllProducts(c *gin.Context)
	SearchProducts(c *gin.Context)
	FilterAndSortProducts(c *gin.Context)
}

func NewProductHandler(pu product.ProductUsecase) ProductHandler {
	return &productHandler{
		productUsecase: pu,
	}
}

func (h *productHandler) CreateProduct(c *gin.Context) {
	var reqProduct requests.Product
	if err := c.ShouldBindJSON(&reqProduct); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	product := models.Product{
		Name:  reqProduct.Name,
		Image: reqProduct.Image,
		Price: reqProduct.Price,

		CategoryID:     reqProduct.CategoryID,
		ManufacturerID: reqProduct.ManufacturerID,
	}

	if err := h.productUsecase.CreateProduct(&product); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, product)
}

func (h *productHandler) UpdateProduct(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	product, err := h.productUsecase.GetProductByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	var reqProduct requests.Product
	if err := c.ShouldBindJSON(&reqProduct); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request payload"})
		return
	}

	product.Name = reqProduct.Name
	product.Image = reqProduct.Image
	product.Price = reqProduct.Price

	product.CategoryID = reqProduct.CategoryID
	product.ManufacturerID = reqProduct.ManufacturerID

	if err := h.productUsecase.UpdateProduct(product); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, product)
}

func (h *productHandler) DeleteProduct(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	product := models.Product{}
	product.ID = uint(id)

	if err := h.productUsecase.DeleteProduct(&product); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"status": "Product deleted"})
}

func (h *productHandler) GetProductByID(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	product, err := h.productUsecase.GetProductByID(uint(id))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, product)
}

func (h *productHandler) GetAllProducts(c *gin.Context) {
	products, err := h.productUsecase.GetAllProducts()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, products)
}

func (h *productHandler) SearchProducts(c *gin.Context) {
	name := c.Query("name")

	products, err := h.productUsecase.SearchProductsByName(name)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, products)
}

func (h *productHandler) FilterAndSortProducts(c *gin.Context) {
	size := c.Query("size")
	minPrice, _ := strconv.ParseFloat(c.Query("min_price"), 64)
	maxPrice, _ := strconv.ParseFloat(c.Query("max_price"), 64)
	color := c.Query("color")
	categoryID, _ := strconv.ParseUint(c.Query("category_id"), 10, 32)

	products, err := h.productUsecase.FilterAndSortProducts(size, minPrice, maxPrice, color, uint(categoryID))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, products)
}
