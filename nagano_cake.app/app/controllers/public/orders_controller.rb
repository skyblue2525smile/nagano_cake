class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @orders_items = @order.ordered_items
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
        @order.post_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.mailling_label = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_option] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.address_post_code = @address.post_code
        @order.adddress_address = @address.address
        @order.maillng_label = @address.name
    else
      reder 'new'
    end

    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @ordered_item = Order.new
      @ordered_item.order_id = @order.id
      @ordered_item.amount = cart_item.amount
      @ordered_item.tax_include_price = (cart_item.price*1.08).floor
      @ordered_item.save
    end

    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:postage, :method_of_payment, :post_code, :address, :mailling_label)
  end
end
