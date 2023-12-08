class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :value, presence: true

  def calculate_average_score
    self.average_score = article.votes.average(:value).to_f
    self.save
  end
end
