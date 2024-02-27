class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  def price
    (item.price* 1.1).round
  end
  
  def subtotal
    price * amount
  end
  
  enum making_status: { not_ready_for_production: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }
  
end