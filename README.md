# テーブル設計

## users テーブル


| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthdate          | date   | null: false               |

### Association
- has_many :purchases
- has_many :items

## items テーブル

| Column           | Type       | Options                        |
| -----------------| ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| shipping_fee_id  | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_day_id  | integer    | null: false                    |
| sale_price       | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association
- belongs_to :user 
- has_one :purchase

## purchases テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column         | Type       | Options                        |
| -------------- | -----------| ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| address_line   | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| purchase       | references | null: false,foreign_key: true  |

### Association
- belongs_to :purchase

○補足
+-------------+            +-----------------------+
|  Items      |            |   ActiveHash (補足)   |
+-------------+            +-----------------------+
| id          |            | Category (category_id)|
| name        |            | ├ id: 1, "---"        |
| category_id |----------> | ├ id: 2, "本"         |
| condition_id|----------> | ├ id: 3, "家電"       |
| shipping_fee_id|------>  | ├ id: 4, "洋服"       |
| shipping_day_id|------>  | Condition (condition_id)|
| prefecture_id|-------->  | ├ id: 1, "---"        |
+-------------+            | ├ id: 2, "新品・未使用"|
                           | ├ id: 3, "やや傷や汚れあり"|
                            +-----------------------+

※ category_id = 2 なら、それは "本" を意味している
