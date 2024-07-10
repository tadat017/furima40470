class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '新品・未使用' },
    { id: 2, name: '未使用に近い' },
    { id: 3, name: '目立った汚れ傷なし' },
    { id: 4, name: 'やや傷汚れあり' },
    { id: 5, name: '傷汚れあり' },
    { id: 6, name: '全体的に状態が悪い' }
  ]

  include ActiveHash::Associations
  has_many :products
end