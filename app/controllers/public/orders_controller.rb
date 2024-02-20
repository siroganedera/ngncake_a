class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    # 注文情報の確認処理を追加する
    if @order.valid?
      render :confirm
    else
      render :new
    end
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
    @cart_items = CartItem.all
    
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    

  end
  def thanks
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private

  def order_params
    params.require(:order).permit(:serect_address, :address_id, :postal_code, :address, :name)
    params[:order][:payment_method]
  end
  
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
