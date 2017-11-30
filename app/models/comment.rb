class Comment < ApplicationRecord
  # association
  belongs_to :contributor
  belongs_to :trick

  # order
  default_scope -> { order(created_at: :asc) }

  # validation
  validates :contributor_id, presence: true
  validates :trick_id, presence: true
  validates :content, presence: true
end
