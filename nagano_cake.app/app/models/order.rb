class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum method_of_payment: { credit_card: 0, transfer: 1}
  enum order_status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

  # def self.order_total_price(orders)
  #   array = []
  #   orders.each do |order|
  #     array << order.item.price * order.amount
  #   end
  #   return (array.sum * 1.1).floor
  # end
end
