class CreateNotesTable < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string   :title
      t.text     :content

      t.belongs_to :notable, polymorphic: true

      t.timestamps
    end 
    add_index :notes, [:notable_id, :notable_type]
  end
end