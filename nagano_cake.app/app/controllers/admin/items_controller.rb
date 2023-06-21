class Admin::ItemsController < ApplicationController
  def index
    @items = items_url(params[:page])
  end

  def new
  end

  def create
    if @items.save
      redirect_to  admin_items_path
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def item_params
    prams.require(:item).permit(:image, :name, :introduction, :price)
  end
end
