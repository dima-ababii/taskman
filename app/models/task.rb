class Task < ApplicationRecord
  # Associations
  has_and_belongs_to_many :users
  
  # Fields validations
  validates :title, presence: true, uniqueness: true
  
  def assign_task_to_user(user_id)
    TasksUser.create(task: self, user_id: user_id)
  end
end
