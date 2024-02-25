class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id]) 
    @order_details = @order.order_details.all
    @total_price = calculate_total_price(@order.order_details)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_params)
      @order_details.update_all(making_status: "waiting_for_production") if @order.status == "payment_confirmed"
    end
      redirect_to admin_order_path(@order)
      
  end
  
  def calculate_total_price(order_detail)
    total_price = 0
    order_detail.each do |order_detail|
      total_price += order_detail.price * order_detail.amount
    end
    return total_price
  end
  
  
  def order_params
    params.require(:order).permit(:status)
  end

end
