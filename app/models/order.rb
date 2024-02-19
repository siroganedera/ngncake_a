class Order < ApplicationRecord
  
  
  
  
  
  def shipping_cost
    800
  end
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipment: 3, shipped: 4 }
end
