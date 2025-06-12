class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_classes, dependent: :destroy
  has_many :user_quests, dependent: :destroy
  has_many :quests, through: :user_quests
  has_many :hero_classes, through: :user_classes
  has_many :questions
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :username, presence: true,
                       uniqueness: true,
                       length: { minimum: 3, maximum: 20 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { minimum: 10, maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true
  validates :password_confirmation, presence: true
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :date_birth, presence: true

  def add_friend(friend)
    Friendship.create(user: self, friend: friend)
  end

  def remove_friend(friend)
    Friendship.find_by(user: self, friend: friend).destroy if Friendship.exists?(user: self, friend: friend)
    Friendship.find_by(user: friend, friend: self).destroy if Friendship.exists?(user: friend, friend: self)
  end

  def followers
    Friendship.where(friend: self).map(&:user)
  end

  def following
    Friendship.where(user: self).map(&:friend)
  end

  def current_class
    user_classes.where(active: true).first
  end

  def inactive_classes
    user_classes.where(active: false)
  end

  def available_hero_classes
    HeroClass.where.not(id: hero_classes.pluck(:id))
  end

  def all_friends
    Friendship.where(user: self).map(&:friend) + Friendship.where(friend: self).map(&:user)
  end

  def all_friendships
    Friendship.where(user: self) + Friendship.where(friend: self)
  end
end
