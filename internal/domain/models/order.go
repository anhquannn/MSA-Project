package models

import (
	"time"

	"gorm.io/gorm"
)

type Order struct {
	gorm.Model
	GrandTotal float64 `json:"grandtotal"`

	UserID     uint `json:"user_id"`
	CartID     uint `json:"cart_id"`
	DeliveryID uint `json:"delivery_id"`

	User     User     `gorm:"foreignKey:UserID"`
	Cart     Cart     `gorm:"foreignKey:CartID"`
	Delivery Delivery `gorm:"foreignKey:DeliveryID"`

	OrderPromoCodes []OrderPromoCode `gorm:"foreignKey:OrderID" json:"order_promo_codes"`
	OrderDetails    []OrderDetail    `gorm:"foreignKey:OrderID" json:"order_details"`
	Payments        []Payment        `gorm:"foreignKey:OrderID" json:"payments"`
	ReturnOrders    []ReturnOrder    `gorm:"foreignKey:OrderID" json:"return_orders"`
	Feedbacks       []Feedback       `gorm:"foreignKey:OrderID" json:"feedbacks"`
}

type Payment struct {
	gorm.Model
	PaymentMethod string  `json:"paymentmethod"`
	Status        string  `json:"status"`
	GrandTotal    float64 `json:"grandtotal"`

	UserID  uint  `json:"user_id"`
	OrderID uint  `json:"order_id"`
	User    User  `gorm:"foreignKey:UserID"`
	Order   Order `gorm:"foreignKey:OrderID"`
}

type OrderDetail struct {
	gorm.Model
	Name       string  `json:"status"`
	Quantity   int     `json:"quantity"`
	UnitPrice  float64 `json:"unitprice"`
	TotalPrice float64 `json:"totalprice"`

	OrderID   uint    `json:"order_id"`
	ProductID uint    `json:"product_id"`
	Product   Product `gorm:"foreignKey:ProductID"`
	Order     Order   `gorm:"foreignKey:OrderID"`
}

type OrderPromoCode struct {
	gorm.Model

	OrderID     uint `json:"order_id"`
	PromoCodeID uint `json:"promocode_id"`

	Order     Order     `gorm:"foreignKey:OrderID"`
	PromoCode PromoCode `gorm:"foreignKey:PromoCodeID"`
}

type PromoCode struct {
	gorm.Model
	Name              string    `json:"name"`
	Code              string    `json:"code"`
	Description       string    `json:"description"`
	StartDate         time.Time `json:"startdate"`
	EndDate           time.Time `json:"enddate"`
	Status            string    `json:"status"`
	DiscountType      string    `json:"discounttype"`
	DiscountValue     float64   `json:"discountvalue"`
	MinimumOrderValue string    `json:"minimumordervalue"`

	OrderPromoCodes []OrderPromoCode `gorm:"foreignKey:PromoCodeID" json:"order_promo_codes"`
}

type ReturnOrder struct {
	gorm.Model
	Status       string  `json:"status"`
	Reason       string  `json:"reason"`
	RefundAmount float64 `json:"refundamount"`

	OrderID uint  `json:"order_id"`
	Order   Order `gorm:"foreignKey:OrderID"`
}

type Feedback struct {
	gorm.Model
	Rating   int    `json:"rating"`
	Comments string `json:"comments"`

	OrderID   uint    `json:"order_id"`
	UserID    uint    `json:"user_id"`
	ProductID uint    `json:"product_id"`
	Order     Order   `gorm:"foreignKey:OrderID"`
	User      User    `gorm:"foreignKey:UserID"`
	Product   Product `gorm:"foreignKey:ProductID"`
}
