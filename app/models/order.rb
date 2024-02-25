class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
  
  validates :payment_method, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  
  
  def shipping_cost
    800
  end
  
  def item_total
    total = 0
    self.order_details.each do |order_detail| 
      total += order_detail.amount
    end
    return total
  end
  
  private
  
#  validates :,presence:true
#  validates :,presence:true,length:{maximum:200}
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { awaiting_payment: 0, payment_confirmed: 1, in_production: 2, preparing_for_shipment: 3, shipped: 4 }
end
