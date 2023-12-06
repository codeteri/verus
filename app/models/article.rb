class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :author, presence: true
  validates :source, presence: true
  validates :content, presence: true
  # length: { minimum: 1000 }

  include PgSearch::Model
  pg_search_scope :search_by_title_and_content,
  against: [ :title, :content ],
  using: {
    tsearch: { prefix: true }
  }

  def leaning
    if votes.any?
      votes_sum = 0
      votes.each do |vote|
        votes_sum += vote.value
      end
      votes_sum.fdiv(votes.size).round(0)
    else
      0
    end
  end
end
