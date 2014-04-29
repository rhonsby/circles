class Post < ActiveRecord::Base
  validates :title, :author, :links, presence: true

  belongs_to :author, class_name: 'User'
  has_many :links, inverse_of: :post, dependent: :destroy

  has_many :post_shares, inverse_of: :post, dependent: :destroy
  has_many :friend_circles, through: :post_shares

  def self.shared_with_user(user)
    @posts = Post.find_by_sql([<<-SQL, user.id])
    SELECT
      posts.*
    FROM
      posts
    JOIN
      post_shares ON posts.id = post_shares.post_id
    JOIN
      friend_circles ON post_shares.friend_circle_id = friend_circles.id
    JOIN
      circle_memberships ON friend_circles.id = circle_memberships.friend_circle_id
    JOIN
      users ON circle_memberships.friend_id = users.id
    WHERE
      users.id = ?
    ORDER BY
      posts.created_at DESC
    SQL
  end
end
