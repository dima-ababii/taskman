class Task < ApplicationRecord
  # Uploader
  mount_uploader :file, TaskUploader
  
  # Associations
  has_many :tasks_users, dependent: :destroy
  has_many :users, through: :tasks_users
  
  # Fields validations
  validates :title, presence: true, uniqueness: true
  validates :expiration_date, presence: true
  validate :expiration_date_is_possible_to_set
  
  def file_name
    begin
      File.basename(self.file&.url)
    rescue
      nil
    end
  end
  
  private
    def expiration_date_is_possible_to_set
      errors.add(:expiration_date, 'can not be set with that date') if Date.current > self.expiration_date
    end
end
