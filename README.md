### Users テーブル

| nickname         | string  | null: false  |
| email            | string  | null: false, unique: true |
|encrypted_password| string  | null: false  |
| last_name        | string  | null: false  |
| first_name       | string  | null: false  |
| last_name_kana   | string  | null: false  |
| first_name_kana  | string  | null: false  |
| date_of_birth    | date    | null: false  |

#### Association
- has_many :products
- has_many :orders

### Products テーブル

| name                | string     | null: false                    |
| description         | text       | null: false                    |
| category_id         | string     | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_fee_id     | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| shipping_duration_id| integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |


#### Association
- belongs_to :user
- belongs_to :condition
- belongs_to :shipping_fee
- belongs_to :prefecture
- belongs_to :shipping_duration
- has_one :order

### Orders テーブル

| user | references | null: false, foreign_key: true |
| product  | references | null: false, foreign_key: true |

#### Association
- belongs_to :user
- belongs_to :product
- has_one :address

### Addresses テーブル

| order        | references | null: false, foreign_key: true |
| postal_code  | string  | null: false |
| prefecture_id| integer | null: false |
| city         | string  | null: false |
| address      | string  | null: false |             |
| phone_number | string  | null: false |
| building     | string  |


#### Association
- belongs_to :order