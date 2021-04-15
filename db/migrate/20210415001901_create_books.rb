class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :author_id
      t.integer :average_rating
      t.string :isbn
      t.string :isbn13
      t.string :language
      t.integer :num_page
      t.integer :ratings_count
      t.integer :text_review_count
      t.date :publication
      t.integer :publisher_id

      t.timestamps
    end
  end
end
