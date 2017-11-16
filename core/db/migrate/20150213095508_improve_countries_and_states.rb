class ImproveCountriesAndStates < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_countries, :states_required, :boolean
  end
end
