class CreatePreferencesTable < ActiveRecord::Migration
  def change
  	create_table :preferences do |t|
      t.string   :name, :limit => 100
      t.string   :value
      t.string   :value_type
      t.string   :key

      t.timestamps
    end
  end
end
