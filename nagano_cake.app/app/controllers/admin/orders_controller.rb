class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.find(params[:id])
    @order = OrderDetail.find(params[:id])
    @order.total_amount = @cart_items.cart_items_total_price(@cart_items)
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.where(order_id: params[:id])

    if @order.update(order_params)
      @order_details.update_all(making_stastus: 1) if @order.status == "payment_confirmation"
      ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
      # @order.status == "入金確認"
      # @order_details.each do |order_detail|
      #   order_detail.make_status = "製作待ち"
      #   order_detail.save
      # end
    end
    redirect_to admin_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
