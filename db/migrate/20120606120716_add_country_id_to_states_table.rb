class AddCountryIdToStatesTable < ActiveRecord::Migration
  def change
    change_table :states do |t|
      t.references :country
    end
  end
end
