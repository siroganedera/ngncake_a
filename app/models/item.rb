class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :item_image

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :item_image
  end

  def add_tax_price
    (self.price * 1.10).round
  end
end
