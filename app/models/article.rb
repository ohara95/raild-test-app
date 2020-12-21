class Article < ApplicationRecord
  belongs_to :user
  # 検証
  validates :title, presence: true, length: {minimum: 6 ,maximum: 100}
  validates :description, presence: true, length: {minimum: 10 ,maximum: 300}
end
