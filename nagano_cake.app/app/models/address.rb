class Address < ApplicationRecord

  belongs_to :customer

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + address_name
  end
end
