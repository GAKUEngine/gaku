class CreateGakuStatesTable < ActiveRecord::Migration
  def change
  	create_table :gaku_states do |t|
      t.string   :name, :abbr, :name_ascii
      t.integer  :code

      t.string :country_iso
    end
  end
end
