class AddTimeFormat24ToPresetsTable < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_presets, :time_format_24, :boolean, default: true
  end
end
