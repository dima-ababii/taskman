class Task < ApplicationRecord
  # Constants
  STATES = %w(new in_progress finnished)
  
  # Callbacks
  
  # Associations
  
  # Associations validations
  
  # Fields validations
  validates :title, presence: true
  validates :state, presence: true
  validate :state_changing
  
  private
    def state_changing
      return if new_record?
      return if state_was == 'new' && state == 'in_progress'
      return if state_was == 'in_progress' && state == 'finnished'
      errors.add(:base, "State can't be #{state} if it was #{state_was}")
    end
end
