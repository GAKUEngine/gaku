class ChangeStateCountryIdToNumCode < ActiveRecord::Migration
  def up
    rename_column :gaku_states, :country_id, :country_numcode
  end

  def down
    rename_column :gaku_states, :country_numcode, :country_id
  end
end
