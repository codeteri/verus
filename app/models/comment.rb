class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :content, presence: true
  validates :likes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :dislikes, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :article_id, presence: true
end
