class TaskResult < ApplicationRecord
  # Uploader
  mount_uploader :file, TaskResultUploader
  
  # Associations
  belongs_to :task
  belongs_to :user
  
  # Associations validations
  validates :task, presence: true
  validates :user, presence: true
  
  # Fields validations
  validates :description, presence: true, if: -> { description }
  validates :file, presence: true, if: -> { file }
  validate :presence_of_answer
  
  private
    def presence_of_answer
      errors.add(:base, 'Description or File must be present') if description.nil? && file.nil?
    end
end
