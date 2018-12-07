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
  validate :presence_of_answer
  
  def file_name
    begin
      File.basename(self.file&.url)
    rescue
      nil
    end
  end
  
  private
    def presence_of_answer
      return if description.length == 0 && !file&.url.nil?
      return if description.length > 0 && file&.url.nil?
      return if description.length > 0 && !file&.url.nil?
      errors.add(:base, 'Description or File must be present')
    end
end
