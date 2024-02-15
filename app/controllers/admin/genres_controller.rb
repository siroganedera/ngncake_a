class Admin::GenresController < ApplicationController
  def create
    @genre= Genre.new
    @genre.admin_id = current_admin.id
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
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genre_path(@genre), notice: "ジャンル名を変更しました。"
    else
      render "edit"
    end
  end
end
