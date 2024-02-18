class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if@item.save
      redirect_to admin_item_path(@item)
    else
      render 'new'
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if@item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render "edit"
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :introduction, :price, :item_image, :is_active)
    end

    def set_item
      @item = Item.find(params[:id])
    end
end