class Favorite < ApplicationRecord
  # association
  belongs_to :contributor
  belongs_to :trick

  # validation
  validates :contributor_id, presence: true
  validates :trick_id, presence: true
end
