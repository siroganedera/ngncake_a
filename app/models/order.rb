class Order < ApplicationRecord
  
  validates :payment_method, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  
  def shipping_cost
    800
  end
  
  
  def total_payment
    total_price = 0
    toral_price += shipping_cost
    order_details.each do |order_detail|
      total_price += order_detail.price * order_detail.amount
    end
    return total_price
  end
  
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipment: 3, shipped: 4 }
end
