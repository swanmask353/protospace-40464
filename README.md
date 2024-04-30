# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false, unique: true |
| profile            | text | null: false |
| occupation         | text | null: false |
| position            | text | null: false |
| encrypted_password | string | null: false |


### Association

- has_many :prototypes
- has_many :comments


## prototypes テーブル

| Column     | Type       | Options     |
| ---------- | -----------| ----------- |
| name       | string     | null: false |
| catch_copy | text       | null: false |
| concept    | text       | null: false |
| user       | references | null: false |


### prototypes　テーブル

- belong to : users
- has_many :comments

## commentsテーブル

| Column    | Type       | Options             |
| ------    | ---------- | ------------------- |
| content   | text       | null: false |
| prototype | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |


### Association

- belongs_to prototypes
- belongs_to :users