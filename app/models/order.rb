class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum method_of_payment: { credit_card: 0, transfer: 1}
  enum order_status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

  def total_price
    total = 0
    order_details.each do |order_detail|
      total += order_detail.quantity * order_detail.purchase_price
      # [+=]をつかうことでeachをまわす毎に左側のtotalに右側の計算結果を足し上げられていく
    end
    return total
  end
end