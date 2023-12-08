class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :bookmarks
  has_many :votes

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'must be a valid email address'}
  validates :username, presence: true, uniqueness: true, length: { minimum: 2, maximum: 30 }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  attribute :consensus_score, :integer, default: 0

  def consensus_score
    total_difference = votes.sum do |vote|
      if vote.value.present? && vote.average_score.present?
        (vote.value - vote.average_score).abs
      else
        0
      end
    end
    votes.count.zero? ? 0 : total_difference / votes.count
  end

  # def leaning
  # end

  # def consensus
  # end

  private

  def password_required?
    new_record? || password.present?
  end

end
