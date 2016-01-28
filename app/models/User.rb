class User < ActiveRecord::Base
  
  has_secure_password
  validates :username, :first_name, :last_name, :email, presence: true

end