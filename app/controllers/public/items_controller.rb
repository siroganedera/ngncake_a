class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private
    def item_params
      params.require(:item).permit(:name, :introduction, :price, :image, :is_active, :genre_id)
    end
end
