class Contributor < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :nick_name, presence: true, length: {maximum: 30 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6}
end
