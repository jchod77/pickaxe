require 'bcrypt'

class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

    def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(pass)
    @password = BCrypt::Password.create(pass)
    self.password_digest = @password
  end

  def self.authenticate(username, password)
    user = User.find_by_username(username)
    return user if user && (user.password == password)
    nil
  end
end