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
- has_many :addresses

### Products テーブル

| name             | string     | null: false                    |
| description      | text       |                                |
| category         | string     | null: false                    |
| condition        | string     | null: false                    |
| shipping_fee     | string     | null: false                    |
| prefecture       | integer    | null: false                    |
| shipping_duration| integer    | null: false                    |
| price            | integer    | null: false                    |

#### Association
- belongs_to :user
- has_many :orders

### Orders テーブル

| product     | references | null: false, foreign_key: true |
| user        | references | null: false, foreign_key: true |

#### Association
- belongs_to :product
- belongs_to :user
- has_one :address

### Addresses テーブル

| order       | references | null: false, foreign_key: true |
| postal_code | string  | null: false |
| prefecture  | string  | null: false |
| city        | string  | null: false |
| address1    | string  | null: false |
| address2    | string  |             |
| phone_number| string  | null: false |

#### Association
- belongs_to :order