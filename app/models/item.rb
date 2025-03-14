class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_day
  belongs_to_active_hash :shipping_fee

  validates :name, presence: true
  validates :description, presence: true
  validates :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id, :image, presence: true

  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "must be other than 1 and can't be blank" }

  validates :sale_price, presence: true,
                         numericality: { only_integer: true,
                                         greater_than_or_equal_to: 300,
                                         less_than_or_equal_to: 9_999_999 }
end
