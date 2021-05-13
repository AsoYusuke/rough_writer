class RenameGemreNameColumnToGenres < ActiveRecord::Migration[5.2]
  def change
    rename_column :genres, :gemre_name, :genre_name
  end
end
