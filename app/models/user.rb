class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true

  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true

  def current_address
    addresses.order(created_at: :desc).first || addresses.build
  end

  has_many :orders
  has_many :shopping_carts
  has_many :order_items, through: :orders

  has_one_attached :profile_image

  # Method to resize images using ActiveStorage
  def profile_image_variant(size)
    profile_image.variant(resize_to_limit: size).processed
  end
  # in view: <%= image_tag current_user.profile_image_variant([300, 300]) %>
end
