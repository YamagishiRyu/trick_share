class Contributor < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validtes :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validtes :nick_name, presence: true
end
