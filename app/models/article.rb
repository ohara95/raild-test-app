class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  # 多対多のリレーションシップを宣言 joinモデルによる間接的な関連付け
  has_many :categories, through: :article_categories
  # 検証
  validates :title, presence: true, length: {minimum: 6 ,maximum: 100}
  validates :description, presence: true, length: {minimum: 10 ,maximum: 300}
end
