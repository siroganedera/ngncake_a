class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @cart_items = current_customer.cart_items # カート内のアイテムを取得するクエリ
    @order = Order.new(order_params)
  
    if @order.save
      @cart_items.each do |cart_item|
        order_detail = @order.order_details.new(
          item_id: cart_item.item_id,
          amount: cart_item.amount,
          price: cart_item.item.price
        )
        order_detail.save
      end
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def confirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    if params[:order][:select_address] == "current_customer"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name

    elsif params[:order][:select_address] == "registered_address"
      @address = Address.find(params[:order][:select_address_address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "address.id"
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    @total_price = calculate_total_price(@order.order_details)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :address_id, :postal_code, :address, :name, :payment_method, :total_payment, :shipping_cost)
  end
  
  
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
  
  def calculate_total_price(order_detail)
    total_price = 0
    order_detail.each do |order_detail|
      total_price += order_detail.price * order_detail.amount
    end
    return total_price
  end
  
  
end
