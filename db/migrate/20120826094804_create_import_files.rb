class CreateImportFiles < ActiveRecord::Migration
  def up
    create_table :import_files do |t|
      t.string :context
    	t.string :importer_type
    end

    add_attachment :import_files, :data_file
  end

  def down
    drop_table :import_files
  end
end
