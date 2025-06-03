class QuestCategory < ApplicationRecord
  validates :name, presence: true
  has_many :quests, dependent: :destroy
end
