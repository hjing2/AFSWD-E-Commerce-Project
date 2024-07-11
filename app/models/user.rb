class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true

  has_many :orders
  has_many :addresses
  has_many :shopping_carts
  has_many :order_items, through: :orders

end
