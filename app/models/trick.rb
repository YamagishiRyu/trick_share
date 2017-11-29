class Trick < ApplicationRecord
  # association
  belongs_to :contributor

  # order
  default_scope -> { order(created_at: :desc) }

  # validation
  validates :contributor_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  validates :duration, presence: true, numericality: :only_integer
end
