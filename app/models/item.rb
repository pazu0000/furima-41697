class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :sale_price, :user_id,
            presence: true
end
