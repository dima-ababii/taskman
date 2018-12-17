class TasksUser < ApplicationRecord
  # Constants
  STATES = %w(new in_progress finished)
  
  # Callbacks
  before_validation :set_assigned_at
  
  # Associations
  belongs_to :task
  belongs_to :user
  
  # Associations validations
  validates :task, presence: true
  validates :user, presence: true
  # validate :parrent_uniqueness
  
  # Fields validations
  validates :assigned_at, presence: true
  validates :state, presence: true, inclusion: { in: TasksUser::STATES }
  
  private
    def set_assigned_at
      self.assigned_at = DateTime.current
    end
    
    def parrent_uniqueness
      return false if TasksUser.find_by(task: task, user: user)
    end
end
