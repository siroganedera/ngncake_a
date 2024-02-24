class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all.order(created_at: :desc)
    @genres = Genre.all
    @cart_item = CartItem
  end
end
