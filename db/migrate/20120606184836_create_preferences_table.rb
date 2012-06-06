class CreatePreferencesTable < ActiveRecord::Migration
  def change
  	create_table :preferences do |t|
      t.string   :name,  :null => false, :limit => 100
      t.integer  :owner_id,   :null => false, :limit => 30
      t.string   :owner_type, :null => false, :limit => 50
      t.string   :value
      t.string   :value_type
      t.string   :key

      t.timestamps
    end
  end
end
