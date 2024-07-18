require 'rails_helper'

# spec/models/user_spec.rb

RSpec.describe User, type: :model do
  describe 'ユーザ登録' do
    context 'ユーザ登録ができる時' do
      it '全ての項目が正しく入力されていれば登録できる' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it '英字のみのパスワードでは登録できない' do
        user = FactoryBot.build(:user, password: 'abcdef', password_confirmation: 'abcdef')
        user.valid?
        expect(user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it '数字のみのパスワードでは登録できない' do
        user = FactoryBot.build(:user, password: '123456', password_confirmation: '123456')
        user.valid?
        expect(user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        user = FactoryBot.build(:user, password: 'ａｂｃｄｅｆ123', password_confirmation: 'ａｂｃｄｅｆ123')
        user.valid?
        expect(user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        user = FactoryBot.build(:user, last_name: 'yamada')
        user.valid?
        expect(user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        user = FactoryBot.build(:user, first_name: 'tarou')
        user.valid?
        expect(user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        user = FactoryBot.build(:user, last_name_kana: 'やまだ')
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end

      it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        user = FactoryBot.build(:user, first_name_kana: 'たろう')
        user.valid?
        expect(user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end
    end
  end
end
