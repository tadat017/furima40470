class Address < ApplicationRecord
  belongs_to :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  #validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }
  #validates :prefecture_id, numericality: { other_than: 0 }
  #validates :city, :addresses, :phone_number, presence: true
  #validates :phone_number, format: { with: /\A\d{10,11}\z/ }
end