class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :value, presence: true
  validates :user_id, presence: true
  validates :article_id, presence: true
end
