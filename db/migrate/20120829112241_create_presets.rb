class CreatePresets < ActiveRecord::Migration
  def change
    create_table :presets do |t|
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end
