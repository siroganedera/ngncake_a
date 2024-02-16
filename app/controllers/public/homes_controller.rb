class Public::HomesController < ApplicationController
  def top
    @genres = genre.all
  end

  def about
  end
end
