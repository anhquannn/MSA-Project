package order

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/order"
)

type ReturnOrderUsecase interface {
	CreateReturnOrder(returnOrder *models.ReturnOrder) error
	UpdateReturnOrder(returnOrder *models.ReturnOrder) error
	DeleteReturnOrder(returnOrder *models.ReturnOrder) error

	GetReturnOrderByID(id uint) (*models.ReturnOrder, error)
}

type returnOrderUsecase struct {
	returnOrderRepo order.ReturnOrderRepository
}

func NewReturnOrderUsecase(returnOrderRepo order.ReturnOrderRepository) ReturnOrderUsecase {
	return &returnOrderUsecase{returnOrderRepo}
}

func (u *returnOrderUsecase) CreateReturnOrder(returnOrder *models.ReturnOrder) error {
	return u.returnOrderRepo.CreateReturnOrder(returnOrder)
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
