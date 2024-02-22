class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  
  def get_image
    if item.image.attached?
      item.image.url
    else
      'no-image-icon'
    end
  end
  
  def add_tax_price
    (self.item.price * 1.1).floor
  end
  
  def subtotal
    (self.item.price* 1.1).floor*amount
  end
    
  
end
