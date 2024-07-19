require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザ登録' do
    context 'ユーザ登録ができる時' do
      it '全ての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したメールアドレスは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが6文字以上でないと登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ａｂｃ１２３'
        @user.password_confirmation = 'ａｂｃ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角6文字以上、英字と数字の両方を含めて設定してください')
      end

      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '姓（全角）が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name 全角文字を使用してください')
      end

      it '名（全角）が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end

      it '姓（カナ）が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カタカナを使用してください')
      end

      it '名（カナ）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カタカナを使用してください')
      end

      it '生年月日が空だと登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end

