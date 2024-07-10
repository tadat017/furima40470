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

| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category         | string     | null: false                    |
| condition        | integer    | null: false                    |
| shipping_fee     | integer    | null: false                    |
| prefecture       | integer    | null: false                    |
| shipping_duration| integer    | null: false                    |
| price            | integer    | null: false                    |
| genre_id         | integer    | null: false                    |


#### Association

- belongs_to :genre
- belongs_to :condition
- belongs_to :shipping_fee
- belongs_to :prefecture
- belongs_to :shipping_duration
- has_one :order

### Orders テーブル

| product     | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |
| buyer_id    | integer    | null: false, foreign_key: true |

#### Association
- belongs_to :product
- belongs_to :user
- belongs_to :buyer, class_name: 'User', foreign_key: 'buyer_id'

### Addresses テーブル

| order       | references | null: false, foreign_key: true |
| postal_code | string  | null: false |
| prefecture  | integer | null: false |
| city        | string  | null: false |
| address     | string  | null: false |             |
| phone_number| string  | null: false |

#### Association
- belongs_to :order