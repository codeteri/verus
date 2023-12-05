class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :content, presence: true, length: { minimum: 2 }
  # validates :user_id, presence: true
  # validates :article_id, presence: true

  def add_like
    @likes = self.likes
    @likes += 1
  end

  def add_dislike
    @dislikes = self.dislikes
    @dislikes += 1
  end
end
