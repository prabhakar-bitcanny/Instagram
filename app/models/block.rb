class Block < ApplicationRecord
  belongs_to :blocked_by, class_name: "User"
  belongs_to :blocked, class_name: "User"
  validates :blocked_by_id, presence: true
  validates :blocked_id, presence: true
end
