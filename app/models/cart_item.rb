class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item


  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def add_tax_price
    (item.price * 1.1).round
  end

  def subtotal
    (item.price* 1.1).round*amount
  end

  #def calculate_total_price
   # total_price = 0
    # self.each do |cart_item|
     #  total_price += cart_item.add_tax_price * cart_item.amount
  #  end
   # return total_price
  #end


end
