class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :bookmarks
  has_many :votes

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address' }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :karma_score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :password, presence: true, length: { minimum: 8 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  before_validation :initialize_karma_score


  private
  def password_required?
    new_record? || password.present?
  end


  def initialize_karma_score
    self.karma_score ||= 0
  end
end
