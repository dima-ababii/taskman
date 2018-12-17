class User < ApplicationRecord
  # Devise
  devise :database_authenticatable, :registerable, :validatable
  
  # Constants
  ROLES = ['student' , 'teacher']
  PASSWORD_FORMAT = /\A
    (?=.*[^a-zA-Z])
  /x
  
  # Callbacks
  
  # Associations
  has_many :tasks_users, dependent: :destroy
  has_many :tasks, through: :tasks_users
  has_many :task_results, dependent: :destroy
  
  # Fields validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }, format: { with: PASSWORD_FORMAT, message: 'must contain at least eight characters and one number or symbol' }, if: :password_present?
  validates :password_confirmation, presence: true, on: :create
  validates :role, presence: true, inclusion: { in: User::ROLES }
  
  
  def email=(value)
    normalizedValue = value
    normalizedValue = value.downcase unless value.nil?
    super(normalizedValue)
  end
  
  def password_present?
    self.password.present?
  end
  
  # The available roles
  def is?(requested_role)
    self.role == requested_role.to_s
  end
end
