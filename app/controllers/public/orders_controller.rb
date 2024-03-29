class Public::OrdersController < ApplicationController

  before_action :check, only: [:new]
  #newアクションの前にcheck（メソッド名）を実行する;注文情報入力画面に行く前にメソッドを実行

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.total_amount =  @order.total_price
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
        @order.post_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.mailling_label = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
        @address = Address.find(params[:order][:address_id])
        @order.post_code = @address.postal_code
        @order.address = @address.address
        @order.mailling_label = @address.address_name
    elsif params[:order][:address_option] == "2"
        @address = Address.new
        @address.customer_id = current_customer.id
        @address.postal_code = params[:order][:post_code]
        @address.address = params[:order][:address]
        @address.address_name = params[:order][:mailling_label]
        # orderのform withでcofirmに送っているparamsのカラムのデータをparams[:order][:orderのカラム名]でとってきている

        @address.save

        @order.post_code = @address.postal_code
        @order.address = @address.address
        @order.mailling_label = @address.address_name
        #上記で行っていること；アドレスを新規作成して、それを新規orderの配送先に指定している
    else
      render 'new'
    end

    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @order.total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      @ordered_item = OrderDetail.new
      @ordered_item.order_id = @order.id
      @ordered_item.item_id = cart_item.item_id
      @ordered_item.quantity = cart_item.amount
      @ordered_item.purchase_price = (cart_item.item.price*1.1).floor
      @ordered_item.save
    end

    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:postage, :method_of_payment, :post_code, :address, :mailling_label, :total_amount)
  end

  def address_params
    params.require(:address).permit(:customer_id, :address_name, :address, :postal_code)
  end

  def check
    if current_customer.cart_items.count == 0
      flash[:alert] = "カートに商品が入っていません。商品を入れてから実行してください。"
      redirect_to items_path
    end
  end
end
