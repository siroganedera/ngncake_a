class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @address = Address.new
  end

  def create
    @order = Order.new(order_params)
    @address = Address.new(address_params)

    if @order.save && @address.save
      # 保存が成功した場合の処理
      redirect_to thanks_orders_path
      
    else
      render :new
    end
  end

  def confirm
    @order_detairs = Order_detair.all
    @order = Order.new
  end

  def thanks
  end

  def index
    @orders = Order.all
  end

  def show
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method)
    params[:order][:select_address]
    # orderのパラメーターを許可する
  end

  def 

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
