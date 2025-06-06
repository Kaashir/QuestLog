class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :user_classes, dependent: :destroy
  has_many :user_quests, dependent: :destroy
  has_many :quests, through: :user_quests
  has_many :hero_classes, through: :user_classes

  def current_class
    user_classes.where(active: true).first
  end

  def inactive_classes
    user_classes.where(active: false)
  end

  def available_hero_classes
    HeroClass.where.not(id: hero_classes.pluck(:id))
  end
end
