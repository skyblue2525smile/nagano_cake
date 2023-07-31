class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def subtotal
    item.with_tax_price * amount
  end

  # def self.cart_items_total_price
  #   total = []
  #   cart_items.each do |cart_item|
  #     total << cart_item.item.price * cart_item.amount
  #   end
  #   return (total.sum * 1.1).floor
  # end
end
