class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :content, presence: true, length: { minimum: 2 }
  # validates :user_id, presence: true
  # validates :article_id, presence: true

  def add_like
    self.likes += 1
    save
  end

  def add_dislike
    self.dislikes += 1
    save
  end
end
