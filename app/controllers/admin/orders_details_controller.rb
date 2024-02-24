class Admin::OrdersDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_orders_path
    else
      render :show, locals: { order_detail: @order_detail } 
    end
  end
end
