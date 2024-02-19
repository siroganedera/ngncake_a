class OrderDetail < ApplicationRecord
  
  
  
  
  
  def subtotal
      item.with_tax_price * amount
  end
  
  enum making_status: { not_ready_for_production: 0, waiting_for_production: 1, in_production: 2, production_completed: 3 }
  
end