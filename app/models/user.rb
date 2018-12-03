class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable, :validatable
  
  # Callbacks
  
  # Associations
  has_and_belongs_to_many :tasks
  
  # Fields validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
