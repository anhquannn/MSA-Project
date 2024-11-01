package order

import (
	"MSA-Project/internal/domain/models"
	"MSA-Project/internal/repositories/order"
)

type PaymentUsecase interface {
	CreatePayment(payment *models.Payment) error
	UpdatePayment(payment *models.Payment) error
	DeletePayment(payment *models.Payment) error

	GetPaymentByID(id uint) (*models.Payment, error)
}

type paymentUsecase struct {
	paymentRepo order.PaymentRepository
}

func NewPaymentUsecase(paymentRepo order.PaymentRepository) PaymentUsecase {
	return &paymentUsecase{paymentRepo}
}

func (u *paymentUsecase) CreatePayment(payment *models.Payment) error {
	return u.paymentRepo.CreatePayment(payment)
}

func (u *paymentUsecase) UpdatePayment(payment *models.Payment) error {
	return u.paymentRepo.UpdatePayment(payment)
}

func (u *paymentUsecase) DeletePayment(payment *models.Payment) error {
	return u.paymentRepo.DeletePayment(payment)
}

func (u *paymentUsecase) GetPaymentByID(id uint) (*models.Payment, error) {
	return u.paymentRepo.GetPaymentByID(id)
}
