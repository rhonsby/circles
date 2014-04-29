class Link < ActiveRecord::Base
  validates :name, :url, :post, presence: true
  validates :url, length: { maximum: 255 }

  belongs_to :post
end
