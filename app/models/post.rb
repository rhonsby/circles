class Post < ActiveRecord::Base
  validates :title, :author, presence: true

  belongs_to :author, class_name: 'User'
  has_many :links, inverse_of: :post
end
