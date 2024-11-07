package requests

import (
	"gorm.io/gorm"
)

type Product struct {
	gorm.Model
	Name  string  `json:"name"`
	Image string  `json:"image"`
	Price float64 `json:"price"`

	CategoryID     *uint `json:"category_id"`
	ManufacturerID *uint `json:"manufacturer_id"`

	ProductDetails []ProductDetail `gorm:"foreignKey:ProductID" json:"product_details"`
}

type Category struct {
	gorm.Model
	Name        string `json:"name"`
	Description string `json:"description"`

	ParentID *uint      `json:"parent_id"`
	Children []Category `gorm:"foreignKey:ParentID" json:"children"`

	Products []Product `gorm:"foreignKey:CategoryID" json:"products"`
}

type ProductDetail struct {
	gorm.Model
	Size          int    `json:"size"`
	Color         string `json:"color"`
	Specification string `json:"specification"`
	Expiry        string `json:"expiry"`
	Description   string `json:"description"`
	StockNumber   int    `json:"stocknumber"`
	StockLevel    string `json:"stocklevel"`

	ProductID uint `json:"product_id"`
}

type Manufacturer struct {
	gorm.Model
	Name    string `json:"name"`
	Address string `json:"address"`
	Contact string `json:"contact"`

	Products []Product `gorm:"foreignKey:ManufacturerID" json:"products"`
}
