class CreateStatesTable < ActiveRecord::Migration
  def change
  	create_table :states do |t|
      t.string   :name, :abbr, :name_ascii
      
      t.references :country
    end
  end
end
