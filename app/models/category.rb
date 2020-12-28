class Category < ApplicationRecord
  # presence -> 空白のバリデート
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  # 名前の一意性の検証
  validates_uniqueness_of :name
  has_many :article_categories
  has_many :articles, through: :article_categories
end