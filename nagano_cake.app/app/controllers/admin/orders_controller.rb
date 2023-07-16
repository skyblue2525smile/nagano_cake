class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.find(params[:id])
    @order = OrderDetail.find(params[:id])
    @order.total_amount = @cart_items.cart_items_total_price(@cart_items)
  end
end
