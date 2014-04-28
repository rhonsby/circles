class Post < ActiveRecord::Base
  validates :title, :author, :friend_circles, :links, presence: true

  belongs_to :author, class_name: 'User'
  has_many :links, inverse_of: :post

  has_many :post_shares, inverse_of: :post
  has_many :friend_circles, through: :post_shares
end
