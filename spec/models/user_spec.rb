require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      nickname: "テストユーザー",
      email: "test@example.com",
      password: "password1",
      password_confirmation: "password1",
      last_name: "山田",
      first_name: "太郎",
      last_name_kana: "ヤマダ",
      first_name_kana: "タロウ",
      date_of_birth: "1990-01-01"
    )
  end

  describe 'バリデーション' do
    it '有効なユーザーであること' do
      expect(@user).to be_valid
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      expect(@user).to_not be_valid
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      expect(@user).to_not be_valid
    end

    it 'メールアドレスが一意であること' do
      @user.save
      another_user = User.new(email: "test@example.com")
      expect(another_user).to_not be_valid
    end

    it 'メールアドレスに@を含むこと' do
      @user.email = 'test.com'
      expect(@user).to_not be_valid
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      expect(@user).to_not be_valid
    end

    it 'パスワードは6文字以上であること' do
      @user.password = 'abc12'
      expect(@user).to_not be_valid
    end

    it 'パスワードは半角英数字混合であること' do
      @user.password = '123456'
      expect(@user).to_not be_valid
    end

    it 'パスワードと確認用パスワードが一致すること' do
      @user.password_confirmation = 'different'
      expect(@user).to_not be_valid
    end

    it 'お名前(全角)が必須であること' do
      @user.last_name = ''
      expect(@user).to_not be_valid
    end

    it 'お名前(カナ)が必須であること' do
      @user.last_name_kana = ''
      expect(@user).to_not be_valid
    end

    it '生年月日が必須であること' do
      @user.date_of_birth = ''
      expect(@user).to_not be_valid
    end
  end
end
  