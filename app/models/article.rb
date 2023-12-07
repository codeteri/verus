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

  def bookmarked?(user)
    # bookmarks.select { |bookmark| bookmark.user == current_user } != []
    bookmarks.exists?(user_id: user.id)
  end

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

  def vote_distribution_percentage(value)
    total_votes = votes.count
    return 0 if total_votes.zero?

    value_votes = votes.where(value: value).count
    (value_votes.to_f / total_votes) * 100
  end

  def leaning_string
    case leaning
    when 1
      "Far Left"
    when 2
      "Left"
    when 3
      "Neutral"
    when 4
      "Right"
    when 5
      "Far Right"
    else
      "No Votes"
    end
  end

  def leaning_style
    case leaning
    when 1
      "background-color: Blue; color: white;"
    when 2
      "background-color: LightBlue; color: blue;"
    when 3
      "background-color: Grey; color: white;"
    when 4
      "background-color: LightCoral; color: white;"
    when 5
      "background-color: Red; color: white;"
    else
      "background-color: White; color: Grey;"
    end
  end
end
