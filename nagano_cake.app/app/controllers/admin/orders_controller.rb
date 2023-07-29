class Admin::OrdersController < ApplicationController
  def index
    # @orders = Order.page(params[:page])
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
    @order_details = @orders.order_detail

    # @order.total_amount = @order.itself.order_total_price(@orders)
    # 各顧客の注文ごとの請求金額合計の算出用コードがきちんと機能していない
  end

  def update
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders
    @order_details = OrderDetail.where(order_id: params[:id])

    if @order.update(order_params)
      @order_details.update_all(making_stastus: 1) if @order.status == "payment_confirmation"
      ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      # @order.status == "入金確認"
      # @order_details.each do |order_detail|
      #   order_detail.make_status = "製作待ち"
      #   order_detail.save
      # end
    end
    redirect_to admin_customer_order_path(@orders.customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
