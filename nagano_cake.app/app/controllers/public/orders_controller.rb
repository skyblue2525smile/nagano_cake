class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    binding.pry
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to
  end

  private
  def order_params
    params.require(:order).permit(:payment_method)
  end
end
