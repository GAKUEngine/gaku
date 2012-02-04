class AddCodeToSyllabuses < ActiveRecord::Migration
  def up
    change_table :syllabuses do |t|
      t.string :code
    end
  end

  def down
    remove_column :syllabuses, :code
  end
end
