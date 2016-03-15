class User < ActiveRecord::Base
	has_secure_password
	validates :email, presence: true
	validates :email,
            :uniqueness => true
	validates :password, presence: true
	validates :name, presence: true

  validates :password, confirmation: true,  length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
