class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_amount, only: [:create]


  def create

    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path, notice: "商品をカート内に入れました"
    else
      @cart_item = CartItem.new
      @item = Item.find(params[:cart_item][:item_id])

      render ("public/items/show")
    end
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
    redirect_to root_path, notice: 'カート内商品を棚に戻しました'
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
