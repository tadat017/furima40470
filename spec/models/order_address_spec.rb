require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  context '内容に問題ない場合' do
    it '全ての項目が正しく入力されていれば保存できる' do
      expect(@order_address).to be_valid
    end

    it 'buildingが空でも保存できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end

  end

  context '内容に問題がある場合' do
    it 'postal_codeが空だと保存できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'postal_codeが正しいフォーマットでないと保存できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'prefecture_idが0だと保存できない' do
      @order_address.prefecture_id = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Prefecture Select')
    end

    it 'cityが空だと保存できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'addressesが空だと保存できない' do
      @order_address.addresses = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
    end

    it 'phone_numberが空だと保存できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが正しいフォーマットでないと保存できない' do
      @order_address.phone_number = '123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid. Enter it as a 10 or 11 digit number')
    end

    it 'tokenが空だと保存できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_idが空だと保存できない' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空だと保存できない' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    
    it 'phone_numberが12桁以上では購入できない' do
      @order_address.phone_number = '090123456789'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid. Enter it as a 10 or 11 digit number')
    end
    
    it 'phone_numberが英数字以外が含まれている場合は購入できない' do
      @order_address.phone_number = '090-1234-5678'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid. Enter it as a 10 or 11 digit number')
    end
  end
end