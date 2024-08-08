rrequire 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.create(:address)
  end

  context '内容に問題ない場合' do
    it '全ての項目が正しく入力されていれば保存できる' do
      expect(@address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'orderが紐付いていないと保存できない' do
      address = FactoryBot.build(:address, order: nil)
      address.valid?
      expect(address.errors.full_messages).to include('Order must exist')
    end
  end
end
