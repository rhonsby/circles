class CircleMembership < ActiveRecord::Base
  validates :friend_circle, :friend, presence: true
  validates :friend_circle, uniqueness: { scope: :friend }

  belongs_to :friend_circle
  belongs_to :friend, class_name: 'User'
end
