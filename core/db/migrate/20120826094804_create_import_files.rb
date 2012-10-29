class CreateImportFiles < ActiveRecord::Migration
  def up
    create_table :gaku_import_files do |t|
      t.string :context
    	t.string :importer_type
    end

    add_attachment :gaku_import_files, :data_file
  end

  def down
    drop_table :gaku_import_files
  end
end
