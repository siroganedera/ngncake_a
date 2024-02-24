class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
    validates :image
  end

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def add_tax_price
    (self.price * 1.10).round
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
