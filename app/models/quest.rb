class Quest < ApplicationRecord
  has_many :user_quests
  has_many :users, through: :user_quests
  has_many :user_classes, through: :users

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :category, presence: true
  validates :frequency, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end
