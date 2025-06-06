class HeroClass < ApplicationRecord
  has_many :user_classes, dependent: :destroy
  has_many :quest_categories, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
