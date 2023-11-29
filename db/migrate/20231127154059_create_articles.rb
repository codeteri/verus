class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :author
      t.text :title
      t.text :source
      t.text :content

      t.timestamps
    end
  end
end
