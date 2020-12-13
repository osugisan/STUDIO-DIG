class CreateStudios < ActiveRecord::Migration[5.2]
  def change
    create_table :studios do |t|

      t.references :user, foreign_key: true, null: false
      t.string :studio_image
      t.string :name, null: false
      t.string :address, null: false
      t.text :explanation
      t.text :url
      t.timestamps
    end
  end
end
