class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable, :validatable
  
  ROLES = ['student' , 'teacher']
  
  # Callbacks
  
  # Associations
  has_many :tasks_users, dependent: :destroy
  has_many :tasks, through: :tasks_users
  # has_and_belongs_to_many :tasks
  
  # Fields validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :role, presence: true, inclusion: { in: User::ROLES }
  
  # The available roles
  def is?(requested_role)
    self.role == requested_role.to_s
  end
end
