class Contributor < ApplicationRecord
  attr_accessor :remember_token

  # association
  has_many :tricks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favo_tricks, through: :favorites, source: :trick
  has_many :comments, dependent: :destroy

  # validation
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :nick_name, presence: true, length: { maximum: 30 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # session
  def Contributor.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Contributor.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Contributor.new_token
    update_attribute(:remember_digest, Contributor.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # favorite
  def like(trick)
    favorites.create(trick_id: trick.id)
  end

  def unlike(trick)
    if t = favorites.find_by(trick_id: trick.id)
      t.destroy
    end
  end

  def like?(trick)
    favo_tricks.include?(trick)
  end
end
