class Tool < ApplicationRecord
  # association
  has_many :need_tools, dependent: :destroy
  has_many :tricks, through: :need_tools, source: :trick

  # validation
  validates :name, presence: true
end
