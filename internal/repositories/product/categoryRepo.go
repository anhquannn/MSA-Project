package product

import (
	"MSA-Project/internal/domain/models"

	"gorm.io/gorm"
)

type CategoryRepository interface {
	CreateCategory(category *models.Category) error
	DeleteCategory(category *models.Category) error
	UpdateCategory(category *models.Category) error

	GetCategoryByID(id uint) (*models.Category, error)
	GetAllCategories(page, pageSize int) ([]models.Category, error)
}

type categoryRepository struct {
	db *gorm.DB
}

func NewCategoryRepository(db *gorm.DB) CategoryRepository {
	return &categoryRepository{db}
}

func (r *categoryRepository) CreateCategory(category *models.Category) error {
	return r.db.Create(category).Error
}

func (r *categoryRepository) DeleteCategory(category *models.Category) error {
	return r.db.Delete(category).Error
}

func (r *categoryRepository) UpdateCategory(category *models.Category) error {
	return r.db.Save(category).Error
}

func (r *categoryRepository) GetCategoryByID(id uint) (*models.Category, error) {
	var category models.Category
	if err := r.db.First(&category, id).Error; err != nil {
		return nil, err
	}
	return &category, nil
}

func (r *categoryRepository) GetAllCategories(page, pageSize int) ([]models.Category, error) {
	var categories []models.Category
	err := r.db.Limit(pageSize).
		Offset((page - 1) * pageSize).
		Find(&categories).Error
	return categories, err
}
