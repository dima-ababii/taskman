class Task < ApplicationRecord
  # Associations
  has_and_belongs_to_many :tasks
  
  # Fields validations
  validates :title, presence: true, uniqueness: true
end
