class Admin::GenresController < ApplicationController
  def create
    @genre= Genre.new
    @genre.user_id = current_user.id
    if@genre.save
      redirect_to genre_path(@genre), notice: "ジャンルを追加しました"
    else
      @genre=Genre.all
    end
  end

  def index
    @genre = Genre.all
    @genre = Genre.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @book.update(genre_params)
      redirect_to genre_path(@genre), notice: "ジャンル名を変更しました。"
    else
      render "edit"
    end
  end
end
