class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])#ページネーションを使用
  end
end
