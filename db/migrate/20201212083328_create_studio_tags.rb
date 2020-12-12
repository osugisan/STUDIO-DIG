class CreateStudioTags < ActiveRecord::Migration[5.2]
  def change
    create_table :studio_tags do |t|

      t.references :studio, foreign_key: true, null: false
      t.references :tag, foreign_key: true, null: false
      t.timestamps
    end
  end
end
