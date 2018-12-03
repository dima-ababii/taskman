class TasksUser < ApplicationRecord
  # Constants
  STATES = %w(new in_progress finished)
  
  # Callbacks
  
  # Associations
  has_and_belongs_to_many :users
  
  # Associations validations
  validates :task, presence: true
  validates :user, presence: true
  validate :parrent_uniqueness
  
  # Fields validations
  validates :state, presence: true, inclusion: { in: TasksUser::STATES }
  validate :state_changing
  
  private
    def parrent_uniqueness
      return false if TasksUser.find_by(task: task, user: user)
    end
  
    def state_changing
      return if new_record?
      return if state_was == 'new' && state == 'in_progress'
      return if state_was == 'in_progress' && state == 'finished'
      errors.add(:base, "State can't be #{state} if it was #{state_was}")
    end
end
