class PostShare < ActiveRecord::Base
  validates :post, :friend_circle, presence: true
  validates :post, uniqueness: { scope: :friend_circle }

  belongs_to :post
  belongs_to :friend_circle
end
