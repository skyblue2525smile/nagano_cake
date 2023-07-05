class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new(cart_item_params)
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
