class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @item = Item.find(params[:id])
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to :index
    else
      @item = Item.find(params[:id])
      render admin_item_path(@item.id)
    end
  end

  def destroy_all
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to :index
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to :index
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items = current_user.cart_items.all
    @cart_items.each do |cart_item|
    if current_customer.cart_items.find_by(item_id: @cart_item.item_id).present?
      @cart_item.amount = cart_item.amount += @cart_item.amount
      cart_item.update_attribute(:amount, new_amount)

    else @cart_item.save
      redirect_to :index
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
