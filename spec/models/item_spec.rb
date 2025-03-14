require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できる場合' do
      it '全ての情報が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it 'imageを1枚つけないと出品できない' do
        @item.image = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'name が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'description が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが1または未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1 and can't be blank")
      end

      it 'condition_idが1または未選択だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1 and can't be blank")
      end

      it 'shipping_fee_idが1または未選択だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee must be other than 1 and can't be blank")
      end

      it 'shipping_day_idが1または未選択だと出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day must be other than 1 and can't be blank")
      end

      it 'prefecture_idが1または未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1 and can't be blank")
      end

      it 'sale_price が空では出品できない' do
        @item.sale_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Sale price can't be blank")
      end

      it 'sale_priceが300未満では出品できない' do
        @item.sale_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Sale price must be greater than or equal to 300')
      end

      it 'sale_priceが9,999,999を超えると出品できない' do
        @item.sale_price = 10_000_000
        @item.valid?
        puts @item.errors.full_messages
        expect(@item.errors.full_messages).to include('Sale price must be less than or equal to 9999999')
      end

      it 'sale_priceが半角数字出なければ出品できない' do
        @item.sale_price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Sale price is not a number')
      end

      it 'ユーザーが紐づいていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
