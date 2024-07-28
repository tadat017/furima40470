FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { 'テスト商品説明' }
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 500 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/star.png'), filename:  'test_image.png', content_type: 'image/jpeg')
    end
  end
end