class Admin::OrdersController < ApplicationController
  def index
    # @orders = Order.page(params[:page])
    @customer = Customer.find(params[:customer_id])
    @orders = @customer.orders.page(params[:page])
  end

  def show
    @order_details = Order.find(params[:id]).order_details
    #Orderモデルから特定のorderの情報を取りだし、それに紐づくorder_detailsのデータをとってくる
    @order = Order.find(params[:id])
    @order.total_amount =  @order.total_price
    # 各顧客の注文ごとの請求金額合計の算出用コード
  end

  def update
    @order_details = Order.find(params[:id]).order_details
    @order = Order.find(params[:id])

    if @order.update(order_params)

      @order_details.update_all(status: 1)
      redirect_to request_referer
    else
      redirect_to request_referer
      # @order_details.update_all(making_stastus: 1) if @order.order_status == "payment_confirmation"
      ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      # 別の書き方
      # @order.status == "入金確認"
      # @order_details.each do |order_detail|
      #   order_detail.make_status = "製作待ち"
      #   order_detail.save
      # end
    end

    # admin_customer_order_path(@orders.customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
