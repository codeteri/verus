class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :author, presence: true
  validates :source, presence: true
  validates :leaning, presence: true
  validates :content, presence: true
  validates :likes, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 0 }
  validates :dislikes, numericality: { only_integer: true, 
                                    greater_than_or_equal_to: 0 }
end
