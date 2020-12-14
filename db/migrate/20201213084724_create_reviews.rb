class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true, null: false
      t.references :studio, foreign_key: true, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.float :rank, null: false

      t.timestamps
    end
  end
end
