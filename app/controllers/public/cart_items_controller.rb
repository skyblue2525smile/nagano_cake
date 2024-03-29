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
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def create
    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id])
      if cart_item.present?
        total_amount = cart_item.amount + cart_item_params[:amount].to_i
        cart_item.update_attribute(:amount, total_amount)
      else
        cart_item_new = CartItem.new(cart_item_params)
        cart_item_new.save

      end
       redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
