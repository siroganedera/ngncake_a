class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  
  def add_tax_price
    (item.price* 1.1).floor
  end
end
