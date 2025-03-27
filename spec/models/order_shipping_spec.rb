require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
  end

  describe '購入商品' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        expect(@order_shipping).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_shipping.building_name = ''
        expect(@order_shipping).to be_valid
      end
      it 'phone_numberが10桁でも保存できる' do
        @order_shipping.phone_number = Faker::Number.leading_zero_number(digits: 10)
        expect(@order_shipping).to be_valid
      end
    end

    context '商品購入できない場合' do
      it 'cityが空では購入できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'address_lineが空では保存できない' do
        @order_shipping.address_line = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address line can't be blank")
      end
      it 'postal_codeが空では保存できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフンが含まれなければ保存できない' do
        @order_shipping.postal_code = '1230854'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeが数字でないと保存できない' do
        @order_shipping.postal_code = 'abc-0854'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'phone_numberが空では保存できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンが含まれる場合保存できない' do
        @order_shipping.phone_number = '050-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid. Enter it as follows(e.g. 09012345678)") # rubocop:disable Style/StringLiterals
      end
      it 'phone_numberが10桁より少ない場合保存できない' do
        @order_shipping.phone_number = Faker::Number.leading_zero_number(digits: 9)
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number is invalid. Enter it as follows(e.g. 09012345678)") # rubocop:disable Style/StringLiterals
      end
      it 'prefectureが0のままでは保存できない' do
        @order_shipping.prefecture_id = 0
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'user_idが空では保存できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では保存できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では保存できない' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
