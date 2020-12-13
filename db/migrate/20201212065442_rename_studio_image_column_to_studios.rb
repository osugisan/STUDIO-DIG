class RenameStudioImageColumnToStudios < ActiveRecord::Migration[5.2]
  def change
    rename_column :studios, :studio_image, :studio_image_id
  end
end
