class Trick < ApplicationRecord
  # association
  belongs_to :contributor
  has_many :favorites, dependent: :destroy
  has_many :liked_contributors, through: :favorites, source: :contributor
  has_many :comments

  # order
  default_scope -> { order(created_at: :desc) }

  # validation
  validates :contributor_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  validates :duration, presence: true, numericality: :only_integer
end
