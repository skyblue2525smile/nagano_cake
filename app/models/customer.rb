class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :cart_items, dependent: :destroy
has_many :orders, dependent: :destroy
has_many :addresses, dependent: :destroy

 validates :is_deleted, inclusion: {in: [true, false]}

  def active_for_authenthication?
    super && !@customer.is_deleted
  end
end
