class Public::OrdersController < ApplicationController
  def new
  end

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
  end

  def thanks
  end

  def create
  end

  private
  def order_params
    params.require(:order).permit(:payment_method)
  end
end
