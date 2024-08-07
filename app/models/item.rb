class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one :order
  
  belongs_to :user
  has_many :orders

  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :name, :description, :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price, :image, presence: true
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, numericality: { other_than: 0, message: "を選択してください" }
  validates :price, numericality: { 
    greater_than_or_equal_to: 300, 
    less_than_or_equal_to: 9_999_999, 
    only_integer: true 
  }
  def sold_out?
    order.present?
  end
end
