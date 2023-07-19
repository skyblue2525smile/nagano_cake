class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum method_of_payment: { credit_card: 0, transfer: 1}
  enum item_status: { sale: 0, discontinued: 1}
end
