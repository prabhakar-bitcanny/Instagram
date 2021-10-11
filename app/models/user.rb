class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  acts_as_messageable

  # for change in url of user's profile
  # extend FriendlyId
  # friendly_id :user_name, use: :slugged

  # devise authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #doorkeeper
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  # Relationships
  has_many :posts, dependent: :destroy
  has_many :postcomments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image

  # validation to user model
  validates :name, presence: true
  validates :user_name, presence: true, uniqueness: true, length: {minimum: 5, maximum: 20}
  validates :email, presence: true, uniqueness: true
  validates :phone_no, presence: true, uniqueness: true, length: {maximum: 10}
  validates :bio, length: {maximum: 150}

  #doorkeeper
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  # Follow feature
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower


  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  # Block feature
  has_many :active_blocks,  class_name:  "Block",
                                  foreign_key: "blocked_by_id",
                                  dependent:   :destroy
  has_many :blocking, through: :active_blocks,  source: :blocked

  has_many :passive_blocks, class_name:  "Block",
                                  foreign_key: "blocked_id",
                                  dependent:   :destroy
  has_many :blocked_by, through: :passive_blocks, source: :blocked_by

  # Blocks a user.
  def block(other_user)
    active_blocks.create(blocked_id: other_user.id)
  end

  # Unblocks a user.
  def unblock(other_user)
    active_blocks.find_by(blocked_id: other_user.id).destroy
  end

  # Returns true if the current user is blocking the other user.
  def blocking?(other_user)
    blocking.include?(other_user)
  end

  #csv download
  def self.to_csv
    attributes = %w{id email name user_name bio phone_no}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end

  # for Search
  def self.search(user_name)
    if user_name
      user_name.downcase!
      where('LOWER(user_name) LIKE ?', "%#{user_name}%")
    else
      all
    end
  end

end
