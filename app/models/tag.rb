class Tag < ApplicationRecord
  # association
  has_many :taggings, dependent: :destroy
  has_many :tagged_tricks, through: :taggings, source: :tricks

  # validation
  validates :name, presence: true, uniqueness: true
end
