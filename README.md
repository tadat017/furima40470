### Users テーブル
| Column     | Type         | Options                       |
|------------|--------------|-------------------------------|
| user_id    | INT          | PRIMARY KEY, AUTO_INCREMENT   |
| username   | VARCHAR(255) | null: false, unique: true     |
| email      | VARCHAR(255) | null: false, unique: true     |
| password   | VARCHAR(255) | null: false                   |
| created_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP     |
| updated_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

### Products テーブル
| Column     | Type         | Options                       |
|------------|--------------|-------------------------------|
| product_id | INT          | PRIMARY KEY, AUTO_INCREMENT   |
| user_id    | INT          | null: false, foreign_key: true |
| name       | VARCHAR(255) | null: false                   |
| description| TEXT         |                               |
| price      | DECIMAL(10, 2)| null: false                  |
| status     | VARCHAR(50)  | DEFAULT 'available'           |
| created_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP     |
| updated_at | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

### Orders テーブル
| Column      | Type         | Options                       |
|-------------|--------------|-------------------------------|
| order_id    | INT          | PRIMARY KEY, AUTO_INCREMENT   |
| product_id  | INT          | null: false, foreign_key: true |
| buyer_id    | INT          | null: false, foreign_key: true |
| seller_id   | INT          | null: false, foreign_key: true |
| total_price | DECIMAL(10, 2)| null: false                  |
| order_status| VARCHAR(50)  | DEFAULT 'pending'             |
| created_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP     |
| updated_at  | TIMESTAMP    | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP |

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