class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id]) 
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order)
    else
      render :show, locals: { order: @order } 
    end
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
    
end
