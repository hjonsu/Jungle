class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    user = User.find_by_email(email)
    (user && user.authenticate(password)) || nil
  end
end
