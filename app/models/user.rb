class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :nickname, presence: true
         validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
         validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
         validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30FC]+\z/, message: '全角カタカナを使用してください' }
         validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30FC]+\z/, message: '全角カタカナを使用してください' }
         validates :date_of_birth, presence: true
         validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角6文字以上、英字と数字の両方を含めて設定してください' }
         
         has_many :items
         
         has_many :orders, through: :items
 end
