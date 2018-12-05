class Task < ApplicationRecord
  # Uploader
  mount_uploader :file, TaskUploader
  
  # Associations
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users
  
  # Fields validations
  validates :title, presence: true, uniqueness: true
  
  def file_name
    begin
      File.basename(self.file&.url)
    rescue
      nil
    end
  end
end
