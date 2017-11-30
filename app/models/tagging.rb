class Tagging < ApplicationRecord
  # association
  belongs_to :trick
  belongs_to :tag

  #validation
  validates :trick_id, presence: true
  validates :tag_id, presence: true
end
