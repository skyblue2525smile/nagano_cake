class Address < ApplicationRecord

  belongs_to :customers

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end
end
