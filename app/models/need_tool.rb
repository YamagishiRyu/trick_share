class NeedTool < ApplicationRecord
  # association
  belongs_to :trick
  belongs_to :tool

  # validation
  validates :trick_id, presence: true
  validates :tool_id, presence: true
end
