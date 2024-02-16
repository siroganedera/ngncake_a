class Admin::GenresController < ApplicationController
  def create
    @genre = Genre.new(genre_params)
    if@genre.save
      redirect_to admin_genres_path(@genre)#, notice: "ジャンルを追加しました"
    else
      @genres=Genre.all
      render 'index'
    end
  end

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path(@genre)#, notice: "ジャンル名を変更しました。"
    else
      render "edit"
    end
  end
  
    private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
  
end
