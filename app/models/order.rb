class Order < ApplicationRecord
  attr_accessor :token
  validates :token, presence: true
  belongs_to :item
  belongs_to :user

 has_one :address, dependent: :destroy
end
