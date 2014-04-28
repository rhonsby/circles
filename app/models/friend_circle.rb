class FriendCircle < ActiveRecord::Base
  validates :name, :owner, presence: true
  validates :name, uniqueness: {
    scope: :owner,
    message: "Each friend circle must have a distinct name" }

  belongs_to :owner, class_name: 'User'

  has_many :circle_memberships, inverse_of: :friend_circle
  has_many :members, through: :circle_memberships, source: :friend

  has_many :post_shares
  has_many :posts, through: :post_shares
end
