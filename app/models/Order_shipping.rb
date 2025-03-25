class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :address_line, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: '. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address_line
    validates :building_name
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be between 10 and 11 digits' },
                             numericality: { only_integer: true, message: 'is invalid. Input only number' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                    phone_number: phone_number, order_id: order.id)
  end
end
