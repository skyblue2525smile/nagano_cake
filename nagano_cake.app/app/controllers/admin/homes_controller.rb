class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @order = OrderDetail.find(params[:id])
  end
end
