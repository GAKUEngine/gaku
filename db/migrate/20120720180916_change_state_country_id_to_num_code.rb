class ChangeStateCountryIdToNumCode < ActiveRecord::Migration
  def up
    rename_column :states, :country_id, :country_numcode
  end

  def down
    rename_column :states, :country_numcode, :country_id
  end
end
