class User < ApplicationRecord

has_secure_password
validates :name, presence: true
validates :email, presence: true, uniqueness: {case_sensitive: false}
validates :password, length: { :minimum => 4 }
before_save { email.downcase! }

def self.authenticate_with_credentials(email, password)
  email.downcase!
  user = User.find_by_email(email.strip)
  if user && user.authenticate(password)
    user
  else
    nil
  end
end


def authenticate_self(email, password)
  self.class.authenticate_with_credentials(email, password)
end


end
