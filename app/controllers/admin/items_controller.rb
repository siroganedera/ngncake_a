class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if@item.save
      redirect_to item_path(@item.id)
    else
      render 'new'
  end

  def index
    @items = Item.all
  end

  def show
  end

  def edit
  end

  def update
  end

  private
    def item_params
      params.require(:item).permit(:name)
end