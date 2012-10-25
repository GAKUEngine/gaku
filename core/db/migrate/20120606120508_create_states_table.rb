class CreateStatesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_states do |t|
      t.string   :name, :abbr, :name_ascii
      t.integer  :code
      
      t.references :country
    end
  end
end
