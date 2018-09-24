class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :recoverable, :validatable
end
