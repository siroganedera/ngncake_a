class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_item
  has_many :order_detail
  has_one_attached :image
end
