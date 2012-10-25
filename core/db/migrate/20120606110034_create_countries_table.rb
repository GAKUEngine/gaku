class CreateCountriesTable < ActiveRecord::Migration
  def change 
    create_table :gaku_countries do |t|
      t.string   :iso_name, :iso, :iso3, :name
      t.integer  :numcode
    end
  end
end
