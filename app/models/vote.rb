class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :value, presence: true

  private

  def calculate_average_score
    self.average_score = article.votes.average(:result).to_f
    self.save
  end
end
