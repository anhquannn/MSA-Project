package order

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/order"
	"MSA-Project/internal/usecases/product"
)

type ReturnOrderUsecase interface {
	CreateReturnOrder(returnOrder *models.ReturnOrder) error
	UpdateReturnOrder(returnOrder *models.ReturnOrder) error
	DeleteReturnOrder(returnOrder *models.ReturnOrder) error

	GetReturnOrderByID(id uint) (*models.ReturnOrder, error)
	GetAllReturnOrders(page int, pageSize int) ([]models.ReturnOrder, error)
}

type returnOrderUsecase struct {
	returnOrderRepo    order.ReturnOrderRepository
	orderDetailUsecase OrderDetailUsecase
	productUsecase     product.ProductUsecase
	orderUsecase       OrderUsecase
}

func NewReturnOrderUsecase(returnOrderRepo order.ReturnOrderRepository, orderDetailUsecase OrderDetailUsecase,
	productUsecase product.ProductUsecase, orderUsecase OrderUsecase) ReturnOrderUsecase {
	return &returnOrderUsecase{returnOrderRepo, orderDetailUsecase, productUsecase, orderUsecase}
}

func (u *returnOrderUsecase) CreateReturnOrder(returnOrder *models.ReturnOrder) error {
	order, err := u.orderUsecase.GetOrderByID(returnOrder.OrderID)
	if err != nil {
		return err
	}

	returnOrder.Status = "Processing..."
	returnOrder.RefundAmount = order.GrandTotal

	if err := u.returnOrderRepo.CreateReturnOrder(returnOrder); err != nil {
		return err
	}

	orderDetails, err := u.orderDetailUsecase.GetOrderDetailsByOrderID(returnOrder.OrderID)
	if err != nil {
		return err
	}

	for _, orderDetail := range orderDetails {
		if err := u.productUsecase.RestoreStock(orderDetail.ProductID, orderDetail.Quantity); err != nil {
			return err
		}
	}

	return err
}

func (u *returnOrderUsecase) UpdateReturnOrder(returnOrder *models.ReturnOrder) error {
	return u.returnOrderRepo.UpdateReturnOrder(returnOrder)
}

func (u *returnOrderUsecase) DeleteReturnOrder(returnOrder *models.ReturnOrder) error {
	return u.returnOrderRepo.DeleteReturnOrder(returnOrder)
}

func (u *returnOrderUsecase) GetReturnOrderByID(id uint) (*models.ReturnOrder, error) {
	return u.returnOrderRepo.GetReturnOrderByID(id)
}

func (u *returnOrderUsecase) GetAllReturnOrders(page int, pageSize int) ([]models.ReturnOrder, error) {
	return u.returnOrderRepo.GetAllReturnOrders(page, pageSize)
}
