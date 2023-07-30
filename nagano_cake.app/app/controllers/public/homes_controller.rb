class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.order('id DESC').limit(4)
  end
end
