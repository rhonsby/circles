class Link < ActiveRecord::Base
  validates :name, :url, :post, presence: true

  belongs_to :post
end
