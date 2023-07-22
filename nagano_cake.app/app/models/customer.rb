class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :cart_items, dependent: :destroy
has_many :orders, dependent: :destroy
has_many :addresses, dependent: :destroy

enum customer_status: { effective: 0, withdrawal: 1}

  def active_for_authenthication?
    super && !@customer.is_deleted
  end
end
