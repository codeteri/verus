class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :author
      t.text :source
      t.integer :leaning
      t.text :content
      t.integer :likes
      t.integer :dislikes

      t.timestamps
    end
  end
end
