class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :sale_price, :user_id,
            presence: true
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
  validates :sale_price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
