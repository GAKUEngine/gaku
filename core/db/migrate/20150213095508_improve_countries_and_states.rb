class ImproveCountriesAndStates < ActiveRecord::Migration
  def change
    add_column :gaku_countries, :states_required, :boolean
  end
end
