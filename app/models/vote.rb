class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :value, presence: true

  def calculate_average_score
    votes_except_current = article.votes.where.not(id: id)
    self.average_score = votes_except_current.average(:value).to_f
    save
  end
end
