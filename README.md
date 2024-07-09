### Users テーブル
| Column           | Type    | Options      |
|------------------|---------|--------------|
| id               | integer | PRIMARY KEY  |
| nickname         | string  | null: false  |
| email            | string  | null: false, unique: true |
| password         | string  | null: false  |
| last_name        | string  | null: false  |
| first_name       | string  | null: false  |
| last_name_kana   | string  | null: false  |
| first_name_kana  | string  | null: false  |
| date_of_birth    | date    | null: false  |

### Products テーブル
| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| id               | integer    | PRIMARY KEY                    |
| user             | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       |                                |
| image            | string     | null: false                    |
| category         | string     | null: false                    |
| condition        | string     | null: false                    |
| shipping_fee     | string     | null: false                    |
| shipping_origin  | string     | null: false                    |
| shipping_duration| string     | null: false                    |
| price            | integer    | null: false                    |
| fee              | integer    | null: false                    |
| profit           | integer    | null: false                    |
| status           | string     | default: 'available'           |

### Orders テーブル
| Column      | Type       | Options     |
|-------------|------------|-------------|
| id          | integer    | PRIMARY KEY |
| product     | references | null: false, foreign_key: true |
| buyer       | references | null: false, foreign_key: { to_table: :users } |
| seller      | references | null: false, foreign_key: { to_table: :users } |

### Addresses テーブル
| Column      | Type    | Options     |
|-------------|---------|-------------|
| id          | integer | PRIMARY KEY |
| user        | references | null: false, foreign_key: true |
| order       | references | null: false, foreign_key: true |
| postal_code | string  | null: false |
| prefecture  | string  | null: false |
| city        | string  | null: false |
| address1    | string  | null: false |
| address2    | string  |             |
| phone_number| string  | null: false |

### Association
- Users
  - has_many :products
  - has_many :orders, foreign_key: :buyer_id
  - has_many :orders, foreign_key: :seller_id
- Products
  - belongs_to :user
  - has_many :orders
- Orders
  - belongs_to :product
  - belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id
  - belongs_to :seller, class_name: 'User', foreign_key: :seller_id