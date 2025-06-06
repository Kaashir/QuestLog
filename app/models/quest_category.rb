class QuestCategory < ApplicationRecord
  validates :name, presence: true
  has_many :quests, dependent: :destroy
  belongs_to :hero_class
end
