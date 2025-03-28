class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number

  POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/
  PHONE_NUMBER_REGEX = /\A\d{10,11}\z/

  with_options presence: true do
    validates :item_id, :user_id, :city, :address_line, :token
    validates :postal_code, format: { with: POSTAL_CODE_REGEX, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX, message: 'is invalid. Enter it as follows(e.g. 09012345678)' }
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                           address_line: address_line, building_name: building_name,
                           phone_number: phone_number, order_id: order.id)
  end
end
