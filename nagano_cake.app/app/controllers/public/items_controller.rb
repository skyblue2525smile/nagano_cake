class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    
    if params[:genre_id] # genre_id?
      # if finded
      @genre = Genre.find(params[:genre_id]) # get genre record
      @items = @genre.items.page(params[:page]) # get item records
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


end
