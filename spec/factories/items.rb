
FactoryBot.define do
  factory :item do
    name { "TestItem" }
    description { "TestDescription" }
    category_id { 1 }
    condition_id { 1 }
    shipping_fee_status_id { 1 }
    prefecture_id { 1 }
    scheduled_delivery_id { 1 }
    price { 3000 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
