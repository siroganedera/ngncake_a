class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]
  before_action :set_genre, only: [:new, :edit]
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
      genre_name = params[:item].delete(:genre)
      genre = Genre.find_by(name: genre_name)
      params.require(:item).permit(:name, :introduction, :price, :image, :is_active).merge(genre: genre)
    end

    def set_item
      @item = Item.find(params[:id])
    end

    def set_genre
      @genres = Genre.all.map { |genre| [ genre.name, genre.id ] }
    end
end