class User < ActiveRecord::Base
	has_secure_password
	attr_readonly :email
	validates :email, presence: true
	validates :email,
            :uniqueness => true
	validates :password, presence: true
	validates :name, presence: true

  validates :password, confirmation: true,  length: { minimum: 6 }
  validates :password_confirmation, presence: true
  has_many :posts
  has_many :folders

end
