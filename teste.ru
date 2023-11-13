require 'bcrypt'

class User
  attr_reader :username

  def initialize(username, password)
    @username = username
    @password_digest = BCrypt::Password.create(password)
  end

  def authenticate(password)
    BCrypt::Password.new(@password_digest) == password
  end
end

# Example usage:
user = User.new('john_doe', 'password123')
user.authenticate('password123') #=> true
user.authenticate('wrong_password') #=> false
require 'bcrypt'

class User < ApplicationRecord
  attr_accessor :password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  before_save :encrypt_password

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password
  end

  private

  def encrypt_password
    self.password_digest = BCrypt::Password.create(password)
  end
end
