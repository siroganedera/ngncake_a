class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
  
    if @order.save!
      redirect_to orders_thanks_path
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
      
    elsif params[:order][:serect_address] == "registered_address" 
      @address = Address.find(params[:order][:serect_address_address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      
    elsif params[:order][:serect_address] == "address.id"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    end
    

    
  end
  
  def thanks
  end

  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :address_id, :postal_code, :address, :name, :payment_method, :total_payment, :shipping_cost)
    
  end
  
   
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
end
