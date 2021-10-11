class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :postcomments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :caption, presence:true, length: {maximum: 100}
end
