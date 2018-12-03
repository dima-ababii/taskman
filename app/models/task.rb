class Task < ApplicationRecord
  # Uploader
  mount_uploader :file, TaskUploader
  
  # Associations
  has_and_belongs_to_many :users
  
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
