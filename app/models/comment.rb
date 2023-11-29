class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :content, presence: true, length: { minimum: 2 }
  validates :user_id, presence: true
  validates :article_id, presence: true
end
