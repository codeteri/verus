class Article < ApplicationRecord
  has_many :comments
  has_many :bookmarks
  has_many :votes
  validates :author, presence: true
  validates :source, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :content, presence: true, length: { minimum: 1000 }
end
