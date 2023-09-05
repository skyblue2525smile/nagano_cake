class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  validates :is_active, inclusion: {in: [true, false]}

  has_one_attached :image

  def get_profile_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/flow01.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
   image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * 1.1).floor
  end
end
