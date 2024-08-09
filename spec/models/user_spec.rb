# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it '重複したメールアドレスは登録できない' do
    another_user = FactoryBot.build(:user, email: @user.email)
    another_user.valid?
    expect(another_user.errors.full_messages).to include("Email has already been taken")
  end
end
