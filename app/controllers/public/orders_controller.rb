class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @address = Address.new(address_params)
  
    if @order.valid? && @address.save
      redirect_to orders_confirm_path
    else
      render :new
    end
  end

  def confirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    #@address = Address.find(params[:order][:address_id])
    if params[:order][:serect_address] == "current_customer"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.last_name+current_customer.first_name
          
    end

    
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
    params.require(:order).permit( :address_id, :postal_code, :address, :name, :payment_method)
    

  end
  
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
