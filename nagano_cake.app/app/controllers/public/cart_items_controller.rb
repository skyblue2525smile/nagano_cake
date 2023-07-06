class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @sum = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @item = Item.find(params[:id])
      render item_path(@item.id)
    end
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    @amount = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      if @amount.present?
        amount = @amount.amount + cart_item_params[:amount].to_i
        @amount.update_attribute(:amount, amount)
      else
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.save

      end
       redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
