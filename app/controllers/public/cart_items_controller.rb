class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_amount, only: [:create]


  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        new_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, new_amount)
        @cart_item.delete
      end 
    end
    @cart_item.save
    redirect_to :cart_items
  end

  def index
    @cart_items = CartItem.all
    @total_price = calculate_total_price(@cart_items)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path(@cart_items), notice: "個数を変更しました。"
    else
      redirect_to cart_items_path, alert: "個数を変更できませんでした。"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カート内商品を棚に戻しました'
  end



  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

  def item_params
    params.require(:item).permit(:name, :price)
  end

  def correct_amount
    if params[:cart_item][:amount] == ""
      flash[:alert] = "個数を選択して下さい"
      redirect_back(fallback_location: root_path)
    end
  end

  def calculate_total_price(cart_items)
    total_price = 0
    cart_items.each do |cart_item|
      total_price += cart_item.add_tax_price * cart_item.amount
    end
    return total_price
  end

end
