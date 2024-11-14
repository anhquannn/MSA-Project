package order

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type FeedbackRepository interface {
	CreateFeedback(feedback *models.Feedback) error
	DeleteFeedback(feedback *models.Feedback) error
	UpdateFeedback(feedback *models.Feedback) error

	GetFeedbackByID(id uint) (*models.Feedback, error)
	GetAllFeedbacksByProductID(productID uint, page, pageSize int) ([]models.Feedback, error)
}

type feedbackRepository struct {
	db *gorm.DB
}

func NewFeedbackRepository(db *gorm.DB) FeedbackRepository {
	return &feedbackRepository{db}
}

func (r *feedbackRepository) CreateFeedback(feedback *models.Feedback) error {
	return r.db.Create(feedback).Error
}

func (r *feedbackRepository) DeleteFeedback(feedback *models.Feedback) error {
	return r.db.Model(&models.Feedback{}).Where("id = ?", feedback.ID).Delete(feedback).Error
}

func (r *feedbackRepository) UpdateFeedback(feedback *models.Feedback) error {
	return r.db.Save(feedback).Error
}

func (r *feedbackRepository) GetFeedbackByID(id uint) (*models.Feedback, error) {
	var feedback models.Feedback
	err := r.db.First(&feedback, id).Error
	return &feedback, err
}

func (r *feedbackRepository) GetAllFeedbacksByProductID(productID uint, page, pageSize int) ([]models.Feedback, error) {
	var feedbacks []models.Feedback
	err := r.db.Where("product_id = ?", productID).
		Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&feedbacks).Error
	return feedbacks, err
}
