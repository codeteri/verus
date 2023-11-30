class AddPhotoUrlToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :photo_url, :text
  end
end
