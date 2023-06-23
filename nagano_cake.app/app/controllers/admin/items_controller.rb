class Admin::ItemsController < ApplicationController
  def index
    @items = items_url(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    if @items.save
      redirect_to  admin_items_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
  end

  private
  def item_params
    prams.require(:item).permit(:image, :name, :introduction, :price)
  end
end
