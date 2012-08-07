class CreateNotesTable < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string   :title
      t.text     :content

      t.references :student

      t.timestamps
    end 
  end
end