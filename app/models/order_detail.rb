class OrderDetail < ApplicationRecord
  
  
  
  def price
    (item.price* 1.1).floor
  end
  
  def subtotal
    price * amount
  end
  
  enum making_status: { not_ready_for_production: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }
  
end